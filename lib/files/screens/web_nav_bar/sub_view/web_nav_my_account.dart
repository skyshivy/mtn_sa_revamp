import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class WebMyAccountButton extends StatefulWidget {
  WebMyAccountButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebMyAccountButtonState();
  }

  List<MenuModel> items = [
    MenuModel(profileStr),
    MenuModel(wishlistStr),
    MenuModel(myTuneStr, imageName: buyImg),
    MenuModel(logoutStr, imageName: likeImg),
  ];
}

class _WebMyAccountButtonState extends State<WebMyAccountButton> {
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 50,
      fontName: FontName.medium,
      fontSize: 16,
      borderColor: white,
      color: white,
      leftWidget: leftWidgetPadding(),
      title: myAccountStr,
      titlePadding: const EdgeInsets.only(right: 14),
      onTap: () {
        showPositionedPopup(_key, widget.items,
            isLeft: false, onTap: navigateTo);
        print("On My Account tapped sss");
      },
    );
  }

  webMyAccountButton() {
    return CustomButton(
      height: 50,
      fontName: FontName.medium,
      fontSize: 16,
      borderColor: white,
      color: white,
      leftWidget: leftWidgetPadding(),
      title: myAccountStr,
      titlePadding: const EdgeInsets.only(right: 14),
      onTap: () {
        Get.dialog(Center(child: CustomAlertView(title: "check here")));
        print("On My Account tapped");
      },
    );
  }

  Padding leftWidgetPadding() {
    return const Padding(
      padding: EdgeInsets.only(left: 14, right: 4),
      child: Icon(Icons.person_2_outlined, size: 20),
    );
  }

  void navigateTo(MenuModel item) {
    if (item.title == profileStr) {
      Get.toNamed(profileTapped);
      print("Profile tapped");
    } else if (item.title == wishlistStr) {
      Get.toNamed(wishlistTapped);
      print("Profile tapped");
    } else if (item.title == myTuneStr) {
      Get.toNamed(myTuneTapped);
      print("Profile tapped");
    }
  }
}
