import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class HomeSearchWidget extends StatelessWidget {
  WebTabController controller = Get.find();
  SearchTuneController searchTuneController = Get.find();
  HomeSearchWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: borderWidget(),
    );
  }

  Widget borderWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 50,
      width: 50,
      decoration: decoration(),
      child: Row(
        children: [
          Expanded(
              child: HomeSearchTextField(
            onChanged: (p0) {
              searchTuneController.searchedText.value = p0;
              //controller.loadPage(3);
              print("onChanged======$p0");
            },
            onSubmit: (p0) {
              controller.loadPage(3);
              searchTuneController.getSearchedResult(p0, 0);
              print("onSubmit======$p0");
            },
            onTap: () {
              controller.loadPage(3);
              Get.back();
              print("text filedon tapped");
            },
          )),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: HomeSearchButton(
              onTap: () {
                controller.loadPage(3);
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
      border: border(),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Border border() {
    return Border.all(color: white);
  }
}
