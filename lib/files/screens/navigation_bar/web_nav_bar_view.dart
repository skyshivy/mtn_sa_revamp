import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_about_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_faq_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_login_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/my_tune_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/web_nav_my_account.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class WebNavBarView extends StatelessWidget {
  AppController appController = Get.find();
  final StatefulNavigationShell navigationShell;

  WebNavBarView({super.key, required this.navigationShell});
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      height: 70,
      color: blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leftWidget(),
          rightWidget(),
        ],
      ),
    );
  }

  Widget leftWidget() {
    return Row(
      children: [
        leftSpacing(),
        HomePageLogoButton(onTap: () {
          _onTap(0);
        }),
        leftSpacing(width: 30),
        HomeMyTuneButton(
          onTap: (category) {
            printCustom("Tapped === ${category.categoryName}");

            Map<String, dynamic> map = {
              "categoryName": category.categoryName ?? '',
              "categoryId": category.categoryId ?? ''
            };
            printCustom("Map is ========$map");
            context.goNamed(tuneGoRoute, queryParameters: map);
            //_onTap(2);
          },
        ),
        // leftSpacing(),
        // HomeAboutButton(),
        leftSpacing(),
        // HomefaqButton(
        //   onTap: () {
        //     _onTap(1);
        //   },
        // ),
        leftSpacing(),
        // CustomButton(
        //   title: "Remove this",
        //   textColor: white,
        //   fontName: FontName.bold,
        //   onTap: () {
        //     context.goNamed(deleteGoRoute);
        //     customPrint("remove this");
        //   },
        // )
      ],
    );
  }

  Widget leftSpacing({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget rightWidget() {
    return Row(
      children: [
        //HomeSearchWidget(),
        leftSpacing(),
        Obx(() {
          return appController.isLoggedIn.value
              ? WebMyAccountButton()
              : const HomeLoginButton();
        }),
        leftSpacing(),
      ],
    );
  }

  void _onTap(index) {
    printCustom("Index is =========$index");
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
