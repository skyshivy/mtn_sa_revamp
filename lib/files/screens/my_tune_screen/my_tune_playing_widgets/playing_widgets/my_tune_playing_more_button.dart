import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class MyTunePlayimgMoreButton extends StatefulWidget {
  final TuneInfo info;
  final int index;

  const MyTunePlayimgMoreButton({
    super.key,
    required this.index,
    required this.info,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyTunePlayimgMoreButtonState();
  }
}

class _MyTunePlayimgMoreButtonState extends State<MyTunePlayimgMoreButton> {
  List<MenuModel> menuItem = [
    //MenuModel(shareStr.tr, imageName: shareSvg),
  ];
  MyTuneController mCont = Get.find();
  createMenuList() {
    menuItem = [
      MenuModel(deleteStr.tr, imageName: deleteSvg),
      //MenuModel(giftStr.tr, imageName: giftTuneSvg),
      //MenuModel(giftStr.tr, imageName: giftTuneSvg),
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
      height: 40,
      width: 40,
      borderColor: grey,
      color: Colors.white38,
      leftWidget: Image.asset(
        moreHorzontalImg,
        width: 20,
        color: black.withOpacity(0.3),
      ), //Icon(Icons.more_horiz, color: black.withOpacity(0.3)),
      onTap: () {
        printCustom(
            "StoreManager().isLoggedIn ====== ${StoreManager().isLoggedIn}");
        if (StoreManager().isLoggedIn) {
          _showPopupMenu();
        } else {
          Get.dialog(
              CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
        }
      },
    );
  }

  _showPopupMenu() {
    showPositionedPopup(
      _key,
      menuItem,
      isSvg: true,
      width: 140,
      isLeft: true,
      onTap: (p0) async {
        if (p0.title == giftStr.tr) {
          Get.dialog(Center(
            child: GiftTuneView(
              info: widget.info ?? TuneInfo(),
            ),
          ));
        } else if (p0.title == deleteStr.tr) {
          mCont.deletePlayingTune(
              widget.info.toneId ?? '', widget.index, context);
        }
        printCustom("Item name is ${p0.title}");
      },
    );
  }
}
