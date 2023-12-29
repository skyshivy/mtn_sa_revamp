import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/set_tune_popup/set_tune_popup.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget setButton(TuneInfo info) {
  return ResponsiveBuilder(
    builder: (context, si) {
      return CustomButton(
        height: 30,
        color: red,
        textColor: white,
        titlePadding: const EdgeInsets.symmetric(horizontal: 20),
        fontName: si.isMobile ? FontName.abook : FontName.aheavy,
        title: setStr,
        onTap: () {
          if (StoreManager().isLoggedIn) {
            Get.dialog(Center(
                child: Material(
                    color: transparent, child: SettunePopup(info: info))));
          } else {
            Get.dialog(
                CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
          }

          print("Open set tune pupup");
        },
      );
    },
  );
}
