import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget myTuneplayingHeaderView() {
  return Container(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftWidget(),
        Row(
          children: [
            _suffleText(),
            _toggleButton(),
          ],
        )
      ],
    ),
  );
}

Widget _leftWidget() {
  return CustomText(
    title: currentlyPlayingToMyCallerStr,
    fontName: FontName.light,
    fontSize: 30,
  );
}

Widget _suffleText() {
  return const CustomText(
    title: shuffleStr,
    fontName: FontName.light,
    fontSize: 18,
    textColor: subTitleColor,
  );
}

Widget _toggleButton() {
  return Switch.adaptive(
    value: false,
    onChanged: (value) {
      print("On change swith");
    },
  );
}
