import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListSettingWidget(ListToneApk1 info) {
  return CustomButton(
    color: blue,
    titlePadding: const EdgeInsets.symmetric(horizontal: 4),
    fontName: FontName.medium,
    fontSize: 16,
    leftWidget: const Padding(
      padding: EdgeInsets.only(left: 6),
      child: Icon(
        Icons.settings,
        size: 23,
        color: white,
      ),
    ),
    height: 40,
    title: settingStr,
    onTap: () {
      var inf = info.toneDetails?.first;
      // String? toneId;
      // String? toneName;
      // String? toneUrl;
      // String? previewImageUrl;
      // String? albumName;
      // String? artistName;
      // int? price;
      // String? createdDate;
      // String? status;
      // String? isCopy;
      // String? isGift;
      // String? toneIdStreamingUrl;
      // String? toneIdpreviewImageUrl;

      Get.toNamed(myTuneSettingTapped, parameters: {
        'toneId': inf?.toneId ?? '',
        'toneName': inf?.toneName ?? '',
        'toneArtist': inf?.artistName ?? '',
        'toneImage': inf?.toneIdpreviewImageUrl ?? '',
      });
      print("tuneListSettingWidget");
    },
  );
}
