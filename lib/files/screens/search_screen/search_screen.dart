import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header.dart';

import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  SearchTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return customScroll(
      _controller,
      ResponsiveBuilder(
        builder: (context, si) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
              child: Obx(() {
                return Column(
                  children: [
                    SearchHeader(),
                    //SeacrhHeaderTab(),
                    //const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: controller.searchType.value == 1
                            ? artistList()
                            : gridView(),
                      ),
                    ),

                    //const SizedBox(height: 30),
                    loadMoreData()
                  ],
                );
              }));
        },
      ),
    );
  }

  Widget loadMoreData() {
    return loadMoreDataButton(
        isLoading: controller.isLoadMore.value,
        rightAction: () {
          controller.loadMoreData();
        });
  }

  Widget artistList() {
    return controller.isLoadingArtist.value
        ? loadingIndicator(height: 300)
        : controller.artistList.isEmpty
            ? emptyWidget(artistListEmptyStr.tr)
            : ResponsiveBuilder(
                builder: (context, si) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.artistList.length,
                    gridDelegate:
                        delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
                    itemBuilder: (context, index) {
                      return artistCell(index, si);
                    },
                  );
                },
              );
  }

  Widget artistCell(int index, SizingInformation si) {
    return InkWell(
      onTap: () {
        context.goNamed(artistGoRoute, queryParameters: {
          'artist': controller.artistList[index]?.matchedParam ?? ''
        });
        // Get.toNamed(artistTuneRoute, parameters: {
        //   "artist": controller.artistList[index].matchedParam ?? ''
        // });
        printCustom(
            "Tapped artist is ${controller.artistList[index]?.matchedParam ?? ''}");
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
                // CustomImage(
                //   radius: 4,
                //   url: defaultImageUrl,
                //   index: index,
                // ),
              ),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: (controller.artistList[index]?.matchedParam ?? '')
                        .toUpperCase(),
                    fontName: si.isMobile ? FontName.medium : FontName.bold,
                    fontSize: si.isMobile ? 12 : 14,
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
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // CustomText(
          //     //   title: (controller.artistList[index].matchedParam ?? '')
          //     //       .toUpperCase(),
          //     //   fontName: FontName.medium,
          //     //   fontSize: 16,
          //     // ),
          //     // const Icon(
          //     //   Icons.arrow_forward_ios,
          //     //   size: 15,
          //     // )
          //   ],
          // ),
          ),
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return controller.isLoading.value
              ? loading()
              : controller.songList.isEmpty
                  ? emptyWidget(tuneListEmptyStr.tr)
                  : GridView.builder(
                      itemCount: controller.songList.length,
                      shrinkWrap: true,
                      gridDelegate: delegate(si,
                          mainAxisExtent: si.isMobile ? 230 : null),
                      itemBuilder: (context, index) {
                        return homeCell(index, si);
                      });
        });
      },
    );
  }

  Widget loading() =>
      Center(child: SizedBox(height: 300, child: loadingIndicator()));

  Widget emptyWidget(String title) {
    return Center(
      child: CustomText(
        title: controller.isLoaded.value ? title : searchTuneStr.tr,
        fontName: FontName.medium,
        fontSize: 16,
      ),
    );
  }

  HomeTuneCell homeCell(int index, SizingInformation si) {
    return HomeTuneCell(
      info: controller.songList[index],
      index: index,
      onTap: si.isMobile
          ? () {
              pushToTunePreView(context, controller.songList, index);
            }
          : null,
    );
  }
}
