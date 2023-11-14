import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class WebMyAccountButton extends StatefulWidget {
  WebMyAccountButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebMyAccountButtonState();
  }

  List<MenuModel> items = [
    MenuModel(profileStr, imageName: profileImage),
    MenuModel(wishlistStr, imageName: favouriteImage),
    MenuModel(myTuneStr, imageName: myTuneImage),
    MenuModel(logoutStr, imageName: logoutImage),
  ];
}

class _WebMyAccountButtonState extends State<WebMyAccountButton> {
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 35,
      fontName: FontName.ztregular,
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
      fontName: FontName.ztregular,
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
    print("Items tapped is ====== $item");
    if (item.title == profileStr) {
      context.goNamed(profileGoRoute);
      //Get.toNamed(profileTapped);
      print("profileTapped tapped");
    } else if (item.title == wishlistStr) {
      //Get.toNamed(wishlistTapped);
      context.goNamed(wishlistGoRoute);
      WishlistController wCont = Get.find();
      if (StoreManager().reloadWishlistView) {
        wCont.getWishlist();
      }
      print("wishlistTapped tapped");
    } else if (item.title == myTuneStr) {
      context.goNamed(myTuneGoRoute);
      print("myTuneTapped tapped");
    } else if (item.title == logoutStr) {
      StoreManager().logout();
    }
  }
}
