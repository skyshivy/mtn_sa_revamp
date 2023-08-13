import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneRepeatDays() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _repeat(),
      const SizedBox(height: 3),
      _dayListView(),
    ],
  );
}

Widget _repeat() {
  return CustomText(
    title: repeatStr,
    fontName: FontName.light,
    fontSize: 13,
    textColor: subTitleColor,
  );
}

Widget _dayListView() {
  return SizedBox(
    height: 30,
    child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        _dayButton("S"),
        _dayButton("M"),
        _dayButton("T"),
        _dayButton("W"),
        _dayButton("T"),
        _dayButton("F"),
        _dayButton("S"),
      ],
    ),
  );
}

Widget _dayButton(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: CustomButton(
      width: 30,
      color: grey,
      height: 30,
      title: title,
    ),
  );
}
