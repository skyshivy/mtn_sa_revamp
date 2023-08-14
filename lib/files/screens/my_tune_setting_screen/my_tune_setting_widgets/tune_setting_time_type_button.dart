import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingTimeTypeButton() {
  return InkWell(
    onTap: () {
      print("tuneSettingTimeTypeButton tapped");
    },
    child: Container(
      height: 60,
      width: 300,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleWidget(),
                _timeTypeTitleWidget(),
              ],
            ),
          ),
          dropIconWidget()
        ],
      ),
    ),
  );
}

Widget _titleWidget() {
  return const CustomText(
    title: selectTimeTypeStr,
    fontName: FontName.light,
    fontSize: 12,
    textColor: subTitleColor,
  );
}

Widget _timeTypeTitleWidget() {
  return const CustomText(
    title: fullDay24HourStr,
    textColor: red,
    fontName: FontName.medium,
    fontSize: 14,
  );
}

Widget dropIconWidget() {
  return const Icon(Icons.arrow_drop_down);
}
