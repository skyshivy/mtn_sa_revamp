import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget giftButton(SizingInformation si, TuneInfo? info) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        _onGiftTap(info);
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
            border: Border.all(color: red)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_giftIcon(si), _giftTitle(si)],
          ),
        ),
      ),
    ),
  );
}

Padding _giftTitle(SizingInformation si) {
  return Padding(
    padding: const EdgeInsets.only(left: 4, top: 3),
    child: CustomText(
        title: giftStr.tr,
        fontSize: si.isMobile ? 13 : 15,
        textColor: black,
        fontName: si.isMobile ? FontName.medium : FontName.bold),
  );
}

SvgPicture _giftIcon(SizingInformation si) {
  return SvgPicture.asset(
    giftTuneSvg,
    height: si.isMobile ? 15 : 18,
    width: si.isMobile ? 15 : 18,
  );
}

void _onGiftTap(TuneInfo? info) {
  if (StoreManager().isLoggedIn) {
    print("Open gift $info");

    Get.dialog(Center(
      child: GiftTuneView(
        info: info ?? TuneInfo(),
      ),
    ));
  } else {
    Get.dialog(CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
  }
}
