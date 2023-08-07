import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

webMyAccountButton() {
  return CustomButton(
    height: 50,
    fontName: FontName.medium,
    fontSize: 16,
    borderColor: white,
    color: white,
    leftWidget: leftWidgetPadding(),
    title: myAccountStr,
    titlePadding: const EdgeInsets.only(right: 14),
    onTap: () {
      print("On My Account tapped");
    },
  );
}

Padding leftWidgetPadding() {
  return const Padding(
    padding: EdgeInsets.only(left: 14, right: 4),
    child: Icon(Icons.person_2_outlined, size: 20),
  );
}
