import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_about_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_faq_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_login_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/my_tune_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/web_nav_my_account.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class WebNavBarView extends StatelessWidget {
  AppController appController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: yellow,
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
        HomePageLogoButton(),
        leftSpacing(width: 30),
        HomeMyTuneButton(),
        // leftSpacing(),
        // HomeAboutButton(),
        leftSpacing(),
        HomefaqButton(),
      ],
    );
  }

  Widget leftSpacing({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget rightWidget() {
    return Row(
      children: [
        HomeSearchWidget(),
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
}
