import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
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
    MenuModel(profileStr, imageName: profileImg),
    MenuModel(wishlistStr, imageName: favouriteImg),
    MenuModel(myTuneStr, imageName: myTuneImg),
    MenuModel(historyStr, imageName: historyImg),
    MenuModel(logoutStr, imageName: logoutImg),
  ];
}

class _WebMyAccountButtonState extends State<WebMyAccountButton> {
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 40,
      fontName: FontName.medium,
      fontSize: 16,
      borderColor: white,
      color: white,
      leftWidget: leftWidgetPadding(),
      title: myAccountStr,
      titlePadding: const EdgeInsets.only(right: 14),
      onTap: () {
        MtnAudioPlayer.instance.stop();
        showPositionedPopup(_key, widget.items,
            isLeft: false, onTap: navigateTo);
        printCustom("On My Account tapped sss");
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
        printCustom("On My Account tapped");
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
    printCustom("Items tapped is ====== $item");
    if (item.title == profileStr) {
      context.goNamed(profileGoRoute);
      //Get.toNamed(profileTapped);
      printCustom("profileTapped tapped");
    } else if (item.title == wishlistStr) {
      //Get.toNamed(wishlistTapped);

      context.goNamed(wishlistGoRoute);
      if (StoreManager().isLoadWishlist) {
        WishlistController con = Get.put(WishlistController());
        con.getWishlist();
      }
      printCustom("wishlistTapped tapped ${StoreManager().isLoadWishlist}");
    } else if (item.title == myTuneStr) {
      context.goNamed(myTuneGoRoute);
      printCustom("myTuneTapped tapped");
    } else if (item.title == logoutStr) {
      StoreManager().logout();
    } else if (item.title == historyStr) {
      context.goNamed(historyGoRoute);
    }
  }
}
