import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class HomeCellTitleSubTilte extends StatelessWidget {
  final TuneInfo? info;
  final Color? titleColor;
  final Color? subTitleColor;
  final String? title;
  final String? subTitle;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final FontName? titleFontName;
  final FontName? subTitleFontName;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  const HomeCellTitleSubTilte({
    super.key,
    this.info,
    this.titleFontSize,
    this.subTitleFontSize,
    this.titleFontName,
    this.subTitleFontName,
    this.title,
    this.subTitle,
    this.titleColor,
    this.subTitleColor,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        CustomText(
          textColor: titleColor,
          maxLine: 1,
          title:
              title ?? info?.toneName ?? info?.contentName ?? "Tune name here",
          fontName: titleFontName ?? FontName.aheavy,
          fontSize: titleFontSize ?? 18,
        ),
        CustomText(
          maxLine: 1,
          title: subTitle ??
              info?.albumName ??
              info?.artistName ??
              ' ARtist name here',
          fontName: subTitleFontName ?? FontName.abook,
          fontSize: subTitleFontSize ?? 12,
          textColor: subTitleColor,
        ),
      ],
    );
  }
}
