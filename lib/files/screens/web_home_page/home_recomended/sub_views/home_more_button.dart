import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class MoreButtonOnCell extends StatefulWidget {
  final TuneInfo? info;
  final bool isWishlist;
  const MoreButtonOnCell({super.key, this.info, required this.isWishlist});

  @override
  State<StatefulWidget> createState() {
    return _MoreButtonOnCellState();
  }
}

class _MoreButtonOnCellState extends State<MoreButtonOnCell> {
  List<MenuModel> menuItem = [];
  @override
  void initState() {
    if (widget.isWishlist) {
      menuItem = [
        MenuModel(deleteStr, imageName: deleteSvg),
        MenuModel(giftStr, imageName: giftSvg),
      ];
    } else {
      menuItem = [
        MenuModel(wishlistStr, imageName: wishlistSvg),
        MenuModel(giftStr, imageName: giftSvg),
      ];
    }

    // MenuModel(shareStr, imageName: shareSvg),

    super.initState();
  }

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [darkGreen, lightGreen])),
      child: CustomButton(
        key: _key,
        height: 30,
        width: 30,
        leftWidget: const Icon(Icons.more_horiz, color: white),
        onTap: () {
          print(
              "StoreManager().isLoggedIn ====== ${StoreManager().isLoggedIn}");
          if (StoreManager().isLoggedIn) {
            showPopupMenu();
          } else {
            Get.dialog(
                CustomAlertView(title: featureIsAvailableForLoggedInStr));
          }
        },
      ),
    );
  }

  showPopupMenu() {
    RecoController recoController = Get.find();
    showPositionedPopup(
      _key,
      menuItem,
      isSvg: true,
      width: 140,
      isLeft: true,
      onTap: (p0) {
        if (p0.title == wishlistStr) {
          recoController.wishlistTapped(widget.info);
        } else if (p0.title == giftStr) {
          recoController.tellAFriendTapped();
        } else if (p0.title == shareStr) {
          recoController.shareTapped();
        } else {
          print("Default tapped");
        }
        print("Item name is ${p0.title}");
      },
    );
  }
}
