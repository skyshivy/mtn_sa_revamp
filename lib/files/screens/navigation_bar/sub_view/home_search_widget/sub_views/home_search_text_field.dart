import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

import '../../../../../custom_files/custom_text_field/custom_text_field.dart';

class HomeSearchTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final Function() onTap;
  final Color textColor;
  final Color hintColor;
  final double? radius;
  final double hPadding;
  final String text;
  const HomeSearchTextField({
    super.key,
    required this.onChanged,
    required this.onSubmit,
    required this.onTap,
    this.hPadding = 22,
    this.textColor = black,
    this.hintColor = white,
    this.radius,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: transparent,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: CustomTextField(
          hPadding: hPadding,
          radius: radius,
          cursorColor: white,
          textColor: textColor,
          isBorder: false,
          hintColor: hintColor,
          fontName: FontName.abook,
          text: text,
          hintText: searchStr.tr,
          fontSize: 16,
          onChanged: onChanged,
          onSubmit: onSubmit,
          onTap: onTap,
        ),
      )),
    );
  }
}
