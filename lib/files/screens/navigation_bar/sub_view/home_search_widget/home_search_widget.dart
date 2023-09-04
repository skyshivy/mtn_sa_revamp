import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
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
    GlobalKey _key = GlobalKey();
    return Container(
      key: _key,
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: 40,
      decoration: decoration(),
      child: Row(
        children: [
          Flexible(
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
              width: 35,
              height: 37,
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
      color: blueLight,
      border: border(),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Border border() {
    return Border.all(color: white);
  }
}
