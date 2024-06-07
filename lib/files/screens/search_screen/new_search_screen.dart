import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/new_search_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
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
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return cont.isLoading.value
                    ? loadingIndicator()
                    : (cont.displayList.isEmpty ? emptyList() : gridView());
              },
            ),
          ),
          nextAndPreviousButtonContainer()
        ],
      ),
    );
  }

  Widget nextAndPreviousButtonContainer() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _previousButton(),
          cont.isLoadingMore.value
              ? SizedBox(height: 30, child: loadingIndicator(radius: 12))
              : _pageNumber(),
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
          fontSize: 18),
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
        child: const Center(
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
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
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget emptyList() {
    return CustomText(title: tuneListEmptyStr);
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return GridView.builder(
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
}
