import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListSettingWidget(BuildContext context, ListToneApk1 info) {
  return CustomButton(
    color: (info.toneDetails?.first.status == "A") ? blue : grey,
    titlePadding: const EdgeInsets.symmetric(horizontal: 4),
    fontName: FontName.medium,
    fontSize: 16,
    textColor: white,
    leftWidget: Padding(
      padding: EdgeInsets.only(left: 6),
      child: Image.asset(
        settingImg,
        width: 20,
        color: white,
      ),
      // Icon(
      //   Icons.settings,
      //   size: 23,
      //   color: white,
      // ),
    ),
    height: 40,
    title: settingStr.tr,
    onTap: () {
      var inf = info.toneDetails?.first;
      if (info.toneDetails?.first.status == "A") {
        Map<String, dynamic> detail = {
          'toneId': inf?.toneId ?? '',
          'toneName': inf?.toneName ?? '',
          'toneArtist': inf?.artistName ?? '',
          'toneImage': inf?.toneIdpreviewImageUrl ?? '',
        };

        context.pushNamed(myTuneSettingGoRoute, queryParameters: detail);
      } else {
        printCustom(
            "Tune status is not active so not moving to setting screen");
      }

      printCustom("tuneListSettingWidget");
    },
  );
}
