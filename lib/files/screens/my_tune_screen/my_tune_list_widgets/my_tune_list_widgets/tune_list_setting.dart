import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListSettingWidget(BuildContext context, ListToneApk1 info) {
  return CustomButton(
    color: darkGreen,
    titlePadding: const EdgeInsets.symmetric(horizontal: 4),
    fontName: FontName.abook,
    fontSize: 16,
    textColor: white,
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

      Map<String, dynamic> detail = {
        'toneId': inf?.toneId ?? '',
        'toneName': inf?.toneName ?? '',
        'toneArtist': inf?.artistName ?? '',
        'toneImage': inf?.toneIdpreviewImageUrl ?? '',
      };

      context.goNamed(myTuneSettingGoRoute, queryParameters: detail);
      print("tuneListSettingWidget");
    },
  );
}
