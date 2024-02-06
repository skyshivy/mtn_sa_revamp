import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';

import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_login_button.dart';

import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/my_tune_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/web_nav_my_account.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class WebNavBarView extends StatelessWidget {
  final AppController appController = Get.find();
  final StatefulNavigationShell navigationShell;
  final RecoController recCont = Get.find();
  final BannerController banCont = Get.find();
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
          rightWidget(context),
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
        muTuneButtonWidget(),
        leftSpacing(width: 20),
        //musicPackWidget(),
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

  Widget musicPackWidget() {
    return CustomButton(
      title: musicPackStr,
      textColor: white,
      fontName: FontName.bold,
      fontSize: 16,
      onTap: () {
        context.goNamed(musicPackGoRoute);
        printCustom("Music pack");
      },
    );
  }

  HomeMyTuneButton muTuneButtonWidget() {
    return HomeMyTuneButton(
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
    );
  }

  Widget leftSpacing({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget rightWidget(BuildContext context) {
    return Row(
      children: [
        homeButtonWidget(),
        //HomeSearchWidget(),
        langugaeButton(context),
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

  Widget homeButtonWidget() {
    return CustomButton(
      height: 60,
      width: 60,
      textColor: white,
      fontName: FontName.bold,
      //title: homeStr.tr,
      leftWidget: const Icon(
        Icons.home,
        color: white,
      ),
      onTap: () {
        context.go(homeGoRoute);
      },
    );
  }

  Widget langugaeButton(BuildContext context) {
    return Obx(() {
      return CustomButton(
        mainPadding: const EdgeInsets.symmetric(horizontal: 20),
        borderColor: white,
        leftWidget: Image.asset(
          languageImg,
          height: 20,
          width: 20,
          color: white,
        ),
        titlePadding: const EdgeInsets.only(left: 3),
        fontName: FontName.medium,
        textColor: white,
        title: appController.isEnglish.value ? burmeseStr : englishStr,
        onTap: () async {
          Get.dialog(CustomConfirmAlertView(
            message: languageChangeConfirmMessageStr.tr,
            cancelTitle: cancelStr,
            onOk: () async {
              CategoryPoupupController cont = Get.find();
              StoreManager().setLanguageEnglish(!StoreManager().isEnglish);
              await Future.delayed(const Duration(milliseconds: 300));
              context.go(homeGoRoute);

              await Future.delayed(const Duration(milliseconds: 300));

              banCont.getBanner();
              cont.getCatList();
              recCont.getTabList();
            },
          )); //CustomAlertView(title: languageChangeConfirmMessageStr));

          printCustom(
              "is selected languagage is English ${StoreManager().isEnglish}");
        },
      );
    });
  }

  void _onTap(index) {
    printCustom("Index is =========$index");
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
