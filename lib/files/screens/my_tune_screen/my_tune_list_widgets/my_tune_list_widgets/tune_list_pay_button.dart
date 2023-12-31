import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListPlayButton() {
  return CustomButton(
    onTap: () {
      print("tuneListPlayButton");
    },
    height: 40,
    borderColor: blueLight,
    titlePadding: const EdgeInsets.symmetric(horizontal: 4),
    //color: yellow,
    title: playStr,
    fontName: FontName.medium,
    fontSize: 16,
    leftWidget: const Icon(
      Icons.play_arrow,
      color: black,
    ),
  );
}
