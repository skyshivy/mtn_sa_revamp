import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/new_search_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/custom_pagination/custom_pagination.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NewSearchScreen extends StatefulWidget {
  const NewSearchScreen({super.key});

  @override
  State<NewSearchScreen> createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  NewSearchController cont = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchHeader(),
        Expanded(
          child: Obx(
            () {
              return cont.isLoading.value
                  ? loadingIndicator()
                  : Obx(() {
                      return cont.searchType.value == SearchType.artistSearch
                          ? artistGridView()
                          : (cont.displayList.isEmpty
                              ? emptyList()
                              : gridView());
                    });
            },
          ),
        ),
        nextAndPreviousButtonContainer()
        /*
        Obx(() {
          return Visibility(
            visible: !(cont.totalCount < pagePerCount),
            child: CustomPagination(
              totalItem: cont.totalCount.value,
              tappedIndex: (p0) {
                cont.loadOnPageNumberData(pageNo: p0 + 1);
                //cont.loadByPageNoData(pageNo: p0 + 1);
              },
            ),
          );
        })
        */
      ],
    );
  }

  Widget nextAndPreviousButtonContainer() {
    return Obx(() {
      return cont.hideMoreButtons.value
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _previousButton(),
                Obx(() {
                  return cont.isLoadingMore.value
                      ? SizedBox(
                          height: 30, child: loadingIndicator(radius: 12))
                      : _pageNumber();
                }),
                _nextButton(),
              ],
            );
    });
  }

  Padding _pageNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomText(
          title: "${cont.currentPage.value + 1}",
          fontName: FontName.bold,
          fontSize: 16),
    );
  }

  Widget _nextButton() {
    return InkWell(
      onTap: () {
        cont.nextButtonAction();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Obx(() {
            return Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: cont.hideNextButton.value ? grey : black,
            );
          }),
        ),
      ),
    );
  }

  Widget _previousButton() {
    return InkWell(
      onTap: () {
        cont.previousButtonAction();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(child: Obx(() {
          return Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: cont.hidePreviousButton.value ? grey : black,
          );
        })),
      ),
    );
  }

  Widget emptyList() {
    return SizedBox(
        child: Center(
            child:
                CustomText(title: tuneListEmptyStr, fontName: FontName.bold)));
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: si.isMobile ? 8 : 30, vertical: 10),
              itemCount: cont.displayList.length,
              shrinkWrap: true,
              gridDelegate:
                  delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
              itemBuilder: (context, index) {
                return homeCell(index, si);
              });
        });
      },
    );
  }

  Widget artistGridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return cont.artistList.isEmpty
              ? emptyList()
              : GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: si.isMobile ? 8 : 30, vertical: 10),
                  itemCount: cont.artistList.length,
                  shrinkWrap: true,
                  gridDelegate:
                      delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
                  itemBuilder: (context, index) {
                    return artistCell(index, si);
                  });
        });
      },
    );
  }

  HomeTuneCell homeCell(int index, SizingInformation si) {
    return HomeTuneCell(
      si: si,
      info: cont.displayList[index],
      index: index,
      onTap: si.isMobile
          ? () {
              pushToTunePreView(context, cont.displayList, index);
            }
          : null,
    );
  }

  Widget artistCell(int index, SizingInformation si) {
    return InkWell(
      onTap: () {
        context.goNamed(artistGoRoute, queryParameters: {
          'artist': cont.artistList[index]?.matchedParam ?? ''
        });
        // Get.toNamed(artistTuneRoute, parameters: {
        //   "artist": controller.artistList[index].matchedParam ?? ''
        // });
        printCustom(
            "Tapped artist is ${cont.artistList[index]?.matchedParam ?? ''}");
      },
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  defaultTuneImagePng,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectionArea(
                    onSelectionChanged: (value) {
                      if (value?.plainText.isEmpty ?? true) {
                      } else {
                        Clipboard.setData(
                            ClipboardData(text: value?.plainText ?? ''));
                      }
                    },
                    child: CustomText(
                      title: (cont.artistList[index]?.matchedParam ?? '')
                          .toUpperCase(),
                      fontName: si.isMobile ? FontName.medium : FontName.bold,
                      fontSize: si.isMobile ? 12 : 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomButton(
                    fontName: si.isMobile ? FontName.medium : FontName.bold,
                    fontSize: si.isMobile ? 12 : 14,
                    width: 80,
                    height: 35,
                    color: blue,
                    title: viewStr.tr,
                    textColor: white,
                  )
                ],
              )
            ],
          )),
    );
  }
}
