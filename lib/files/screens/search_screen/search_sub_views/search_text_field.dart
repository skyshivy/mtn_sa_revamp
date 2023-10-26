import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({super.key});
  final SearchTuneController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Visibility(
          visible: si.isMobile,
          child: Column(
            children: [
              seperatorWidget(),
              mainContainer(context),
            ],
          ),
        );
      },
    );
  }

  Container mainContainer(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(gradient: customGredient()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: textFieldContainer(context),
      ),
    );
  }

  Container textFieldContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: white),
          borderRadius: BorderRadius.circular(4)),
      height: 35,
      child: Row(
        children: [
          Expanded(
            child: HomeSearchTextField(
                text: cont.searchedText.value,
                textColor: white,
                hintColor: white.withOpacity(0.6),
                onChanged: (value) {
                  cont.searchedText.value = value;
                  cont.isLoaded.value = false;
                  cont.songList.value = [];
                  cont.toneList.value = [];
                  cont.artistList.value = [];
                  if (cont.searchedText.value.isEmpty) {
                    return;
                  }
                },
                onSubmit: (value) {
                  cont.searchedText.value = value;
                  if (cont.searchedText.value.isEmpty) {
                    return;
                  }
                  context
                      .goNamed(searchGoRoute, queryParameters: {"key": value});
                },
                onTap: () {
                  if (cont.searchedText.value.isEmpty) {
                    return;
                  }
                }),
          ),
          searchButton(context),
        ],
      ),
    );
  }

  Container seperatorWidget() {
    return Container(
      height: 1,
      color: white,
    );
  }

  Widget searchButton(BuildContext context) {
    return HomeSearchButton(
        width: 40,
        onTap: () {
          context.goNamed(searchGoRoute,
              queryParameters: {"key": cont.searchedText.value});
        });
  }
}
