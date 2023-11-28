import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

import '../custom_text/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double? fontSize;
  final int? maxLine;
  final FontName fontName;
  final TextAlign alignment;
  final FontWeight? fontWeight;
  final EdgeInsets titlePadding;
  final Function()? onTap;

  const CustomTextButton({
    super.key,
    required this.title,
    this.textColor = black,
    this.fontSize = 14,
    this.maxLine,
    this.titlePadding = const EdgeInsets.all(0),
    this.fontName = FontName.medium,
    this.alignment = TextAlign.start,
    this.fontWeight = FontWeight.bold,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: titlePadding,
        child: CustomText(
          title: title.tr,
          textColor: textColor,
          fontName: fontName,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
