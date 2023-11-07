import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/custom_files/tell_a_friend_view.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_from_wishlist_vm.dart';

class HomeMoreButton extends StatefulWidget {
  final TuneInfo? info;
  final int index;
  final bool isWishlist;

  const HomeMoreButton(
      {super.key, this.info, required this.isWishlist, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _HomeMoreButtonState();
  }
}

class _HomeMoreButtonState extends State<HomeMoreButton> {
  List<MenuModel> menuItem = [
    //MenuModel(shareStr, imageName: shareSvg),
  ];
  late WishlistController wishCont;
  createMenuList() {
    if (widget.isWishlist) {
      wishCont = Get.find();
    }
    menuItem = [
      widget.isWishlist
          ? MenuModel(deleteStr, imageName: deleteSvg)
          : MenuModel(wishlistStr, imageName: wishlistSvg),
      MenuModel(tellFriendStr, imageName: tellFriendSvg),
    ];
  }

  @override
  void initState() {
    createMenuList();
    super.initState();
  }

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 30,
      width: 30,
      color: Colors.white38,
      leftWidget: const Icon(Icons.more_horiz, color: white),
      onTap: () {
        printCustom(
            "StoreManager().isLoggedIn ====== ${StoreManager().isLoggedIn}");
        if (StoreManager().isLoggedIn) {
          showPopupMenu();
        } else {
          Get.dialog(CustomAlertView(title: featureIsAvailableForLoggedInStr));
        }
      },
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
      onTap: (p0) async {
        if (p0.title == wishlistStr) {
          recoController.wishlistTapped(widget.info);
        } else if (p0.title == tellFriendStr) {
          recoController.tellAFriendTapped();
          Get.dialog(Center(
            child: TellAFriendView(
              info: widget.info ?? TuneInfo(),
            ),
          ));
        } else if (p0.title == shareStr) {
          recoController.shareTapped();
        } else if (p0.title == deleteStr) {
          wishCont.deleteFromWishlistAction(
              widget.info ?? TuneInfo(), widget.index);

          printCustom("Delete from wishlis make api call here");
        } else {
          printCustom("Default tapped");
        }
        printCustom("Item name is ${p0.title}");
      },
    );
  }
}
