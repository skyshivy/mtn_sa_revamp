import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/add_to_wishist_vm.dart';

Widget tunePreviewWishlistView(
    TunePreviewController pCont, PlayerController playCont, TuneInfo info) {
  return Container(
    height: 60,
    decoration: _decoration(),
    child: Obx(() {
      return pCont.isAddingWishlist.value
          ? Center(child: loadingIndicator(radius: 10))
          : buttonWidget(pCont, info);
    }),
  );
}

InkWell buttonWidget(TunePreviewController pCont, TuneInfo info) {
  return InkWell(
    onTap: () async {
      pCont.stopPlayer();
      if (StoreManager().isLoggedIn) {
        pCont.addToWishlistAction(info);
      } else {
        Get.dialog(CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
      }
      printCustom("tunePreviewWishlistView tapped");
    },
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(wishlistSvg),
        CustomText(
          title: wishlistStr.tr,
          fontName: FontName.medium,
          fontSize: 12,
        ),
      ],
    )),
  );
}

BoxDecoration _decoration() {
  return const BoxDecoration(
    color: greyLight,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  );
}
