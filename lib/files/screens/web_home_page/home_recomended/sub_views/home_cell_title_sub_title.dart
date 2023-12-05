import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

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
        InkWell(
          onTap: () {
            print(
                "Tapped== ${title ?? info?.toneName ?? info?.contentName ?? ""}");
          },
          child: Tooltip(
            waitDuration: const Duration(milliseconds: 600),
            message: title ?? info?.toneName ?? info?.contentName ?? "",
            child: CustomText(
              textColor: titleColor,
              maxLine: 1,
              title: title ??
                  info?.toneName ??
                  info?.contentName ??
                  "Tune name here",
              fontName: titleFontName ?? FontName.bold,
              fontSize: titleFontSize ?? 18,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            print("on artist tap");
          },
          child: Tooltip(
            waitDuration: const Duration(milliseconds: 600),
            message: subTitle ??
                info?.albumName ??
                info?.artistName ??
                ' ARtist name here',
            child: CustomText(
              maxLine: 1,
              title: subTitle ??
                  info?.albumName ??
                  info?.artistName ??
                  ' ARtist name here',
              fontName: subTitleFontName ?? FontName.mediumItalic,
              fontSize: subTitleFontSize ?? 12,
              textColor: subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}
