import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/main.dart';

import 'package:responsive_builder/responsive_builder.dart';

class HomeSearchWidget extends StatelessWidget {
  final WebTabController controller = Get.find();
  final SearchTuneController searchTuneController = Get.find();
  HomeSearchWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return SizedBox(
          width: si.isMobile ? double.infinity : 300,
          child: borderWidget(context, si),
        );
      },
    );
  }

  Widget borderWidget(BuildContext context, SizingInformation si) {
    GlobalKey key = GlobalKey();
    return Container(
      key: key,
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: 40,
      decoration: decoration(),
      child: Row(
        children: [
          Flexible(
              child: HomeSearchTextField(
            hintColor: atomCryan,
            textColor: white,
            onChanged: (p0) {
              searchTuneController.searchedText.value = p0;
              //controller.loadPage(3);

              print("onChanged======$p0");
            },
            onSubmit: (p0) {
              if (si.isMobile) {
                print("onChanged====asdas==$p0");
                //Get.toNamed(searchTapped);
                context.goNamed(searchGoRoute, queryParameters: {"key": p0});
              } else {
                //controller.loadPage(3);
                context.goNamed(searchGoRoute, queryParameters: {"key": p0});
              }
              //searchTuneController.getSearchedResult(p0, 0);

              print("onSubmit======$p0");
            },
            onTap: () {
              controller.loadPage(3);
              //Get.back();
              print("text filedon tapped");
            },
          )),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: HomeSearchButton(
              width: 35,
              height: 37,
              onTap: () {
                if (si.isMobile) {
                  print("text filedon tapped");
                  //Get.toNamed(searchTapped);
                } else {
                  controller.loadPage(3);
                }

                //context.goNamed(searchRoute, queryParameters: {"key": p0});
                searchTuneController.getSearchedResult(
                    searchTuneController.searchedText.value, 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      color: blue,
      border: border(),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Border border() {
    return Border.all(color: white);
  }
}
