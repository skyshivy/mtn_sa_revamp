import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListSettingWidget() {
  return CustomButton(
    color: yellow,
    titlePadding: EdgeInsets.symmetric(horizontal: 4),
    fontName: FontName.medium,
    fontSize: 16,
    leftWidget: Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Icon(
        Icons.settings,
        size: 23,
        color: white,
      ),
    ),
    height: 40,
    title: settingStr,
    onTap: () {
      print("tuneListSettingWidget");
    },
  );
}
