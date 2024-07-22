import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/new_search_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';

import 'package:mtn_sa_revamp/files/go_router/route_name.dart';

import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_type_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeSearchWidget extends StatelessWidget {
  final WebTabController controller = Get.find();
  final SearchTuneController searchTuneController = Get.find();
  final NewSearchController newSearchController = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  HomeSearchWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: si.isMobile ? double.infinity : 700,
              child: borderWidget(context, si),
            ),
            const SizedBox(height: 10),
            HomeSearchTypeButton()
          ],
        );
      },
    );
  }

  Widget borderWidget(BuildContext context, SizingInformation si) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: 40,
      decoration: decoration(),
      child: Row(
        children: [
          Expanded(
              child: HomeSearchTextField(
            hintColor: blue,
            textColor: black,
            onChanged: (p0) {
              searchTuneController.searchedText.value = p0;
              newSearchController.searchedText = p0;
              newSearchController.updateSearchedText(p0);
              //controller.loadPage(3);
            },
            onSubmit: (p0) {
              if (p0.isNotEmpty) {
                context.goNamed(searchGoRoute, queryParameters: {
                  "key": p0,
                  "index": "${searchTuneController.searchType.value}",
                });
                SearchType searchType =
                    getSearchType("${searchTuneController.searchType.value}");
                newSearchController.getSearchedResult(searchType);
                // searchTuneController.stopMultipleApiCall = true;
                // searchTuneController.getSearchedResult(
                //     searchTuneController.searchedText.value, 0);
              }
            },
            onTap: () {
              controller.loadPage(3);

              printCustom("text filedon tapped");
            },
          )),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: HomeSearchButton(
              width: 35,
              height: 37,
              onTap: () {
                if (newSearchController.searchedText.isNotEmpty) {
                  context.goNamed(searchGoRoute, queryParameters: {
                    "key": searchTuneController.searchedText.value,
                    "index": "${searchTuneController.searchType.value}",
                  });
                  SearchType searchType =
                      getSearchType("${searchTuneController.searchType.value}");
                  newSearchController.getSearchedResult(searchType);
                  // searchTuneController.stopMultipleApiCall = true;
                  // searchTuneController.getSearchedResult(
                  //     searchTuneController.searchedText.value, 0);
                }
                printCustom("On search tapped");
              },
            ),
          ),
        ],
      ),
    );
  }

  SearchType getSearchType(String index) {
    printCustom("index = $index");
    if (index == "0") {
      return SearchType.toneSearch;
    } else if (index == "1") {
      return SearchType.artistSearch;
    } else if (index == "2") {
      return SearchType.toneIdSearch;
    } else if (index == "3") {
      return SearchType.nameToneSearch;
    } else {
      return SearchType.toneSearch;
    }
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: white,
      border: border(),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Border border() {
    return Border.all(color: white);
  }
}
