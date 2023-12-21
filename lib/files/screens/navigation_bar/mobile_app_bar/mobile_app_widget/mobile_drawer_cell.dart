// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/drawer_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget mobileDrawerCell(BuildContext context, DrawerModel info) {
  MyDrawerController controller = Get.find();
  return InkWell(
    splashColor: transparent,
    onTap: () {
      printCustom("Tapped ==========");
      if (info.isExpandable!.value) {
        info.isSelected!.value = !info.isSelected!.value;
      } else {
        printCustom("123 Tapped ==========");
        _tappedOnCell(context, info.title);
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: info.title,
                fontName: FontName.medium,
                fontSize: 16,
              ),
              info.isExpandable!.value ? _expandedIcon(info) : const SizedBox()
            ],
          ),
          _subList(context, info, controller)
        ],
      ),
    ),
  );
}

Widget _expandedIcon(DrawerModel info) {
  return Obx(() {
    return Icon(
      info.isSelected!.value ? Icons.arrow_drop_down : Icons.arrow_forward_ios,
      size: 14,
    );
  });
}

Widget _subList(
    BuildContext context, DrawerModel info, MyDrawerController controller) {
  return Obx(() {
    return info.isSelected!.value
        ? Column(
            children: [
              const SizedBox(height: 16),
              sunListWidget(controller),
            ],
          )
        : const SizedBox();
  });
}

ListView sunListWidget(MyDrawerController controller) {
  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.catList.length,
      itemBuilder: (context, index) {
        return _subListCell(controller, context, index);
      });
}

Widget _subListCell(
    MyDrawerController controller, BuildContext context, int index) {
  return InkWell(
    splashColor: transparent,
    hoverColor: transparent,
    //focusColor: transparent,
    onTap: () {
      _tappedOnSubCell(context, controller.catList[index]);
      // _expandedIcon(info);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Center(
              child: CustomText(
                title: controller.catList[index].categoryName ?? '',
                fontName: FontName.medium,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

_tappedOnSubCell(BuildContext context, AppCategory cat) async {
  Navigator.pop(context);
  await Future.delayed(const Duration(milliseconds: 100));

  Map<String, dynamic> map = {
    "categoryName": cat.categoryName ?? '',
    "categoryId": cat.categoryId ?? ''
  };
  printCustom("Map is ========$map");
  context.goNamed(tuneGoRoute, queryParameters: map);

  // Get.toNamed(tuneCatTapped, parameters: {
  //   'categoryName': cat.categoryName ?? '',
  //   'categoryId': cat.categoryId ?? ''
  // });
  printCustom("object ==== ${cat.categoryId}");
}

_tappedOnCell(BuildContext context, String title) async {
  printCustom("=========_tappedOnCell==============");
  if ((title == englishStr.tr) || (title == burmeseStr.tr)) {
  } else {
    Navigator.pop(context);
  }

  await Future.delayed(const Duration(milliseconds: 100));
  if (title == homeStr.tr) {
    context.go(homeGoRoute);
  } else if (title == profileStr.tr) {
    ProfileController profileController = Get.find();
    context.goNamed(profileGoRoute);
    profileController.getProfileDetail();
    //Get.toNamed(profileTapped);
  } else if (title == myTuneStr.tr) {
    context.goNamed(myTuneGoRoute);
    //Get.toNamed(myTuneTapped);
  } else if (title == wishlistStr.tr) {
    context.goNamed(wishlistGoRoute);
    //Get.toNamed(wishlistTapped);
  } else if (title == faqStr.tr) {
    printCustom("FAQ tapped");
    context.goNamed(faqGoRoute);
    //Get.toNamed(faqTapped);
  } else if (title == logoutStr.tr) {
    printCustom("Logout btapped");
    StoreManager().logout();
  } else if (title == signinStr.tr) {
    Get.dialog(const LoginScreen(), barrierDismissible: false);
  } else if (title == historyStr.tr) {
    context.goNamed(historyGoRoute);
  } else if ((title == englishStr.tr) || (title == burmeseStr.tr)) {
    Get.dialog(CustomConfirmAlertView(
      message: languageChangeConfirmMessageStr,
      okTitle: confirmStr,
      cancelTitle: cancelStr,
      onOk: () async {
        print("Change langugage here");
        BannerController banCont = Get.find();
        RecoController recCont = Get.find();
        CategoryPoupupController cont = Get.find();
        StoreManager().setLanguageEnglish(!StoreManager().isEnglish);
        await Future.delayed(const Duration(milliseconds: 300));
        context.go(homeGoRoute);

        await Future.delayed(const Duration(milliseconds: 300));
        cont.getCatList();
        banCont.getBanner();
        recCont.getTabList();

        Navigator.pop(context);
        printCustom(
            "is selected languagage is English ${StoreManager().isEnglish}");
      },
    ));
  } else {
    printCustom("=========Default tapped==============");
  }
}
