import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
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
    return SelectionArea(
      onSelectionChanged: (value) {
        if (value?.plainText.isEmpty ?? true) {
        } else {
          Clipboard.setData(ClipboardData(text: value?.plainText ?? ''));
        }
      },
      contextMenuBuilder: (context, selectableRegionState) {
        print("selectableRegionState ${selectableRegionState}");
        return Container(
          height: 20,
          width: 300,
          color: red,
        );
      },
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            onTriggered: () async {
              Clipboard.setData(ClipboardData(
                      text:
                          "${title ?? info?.toneName ?? info?.contentName ?? ""}"))
                  .then((_) {
                Get.snackbar("Copied",
                    "${title ?? info?.toneName ?? info?.contentName ?? ""}",
                    backgroundColor: white,
                    duration: const Duration(seconds: 2));
              });

              print(
                  "Tapped text is ${title ?? info?.toneName ?? info?.contentName ?? ""}");
            },
            waitDuration: const Duration(milliseconds: 600),
            message: title ?? info?.toneName ?? info?.contentName ?? "",
            child: CustomText(
              overFlow: TextOverflow.ellipsis,
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
          Tooltip(
            waitDuration: const Duration(milliseconds: 600),
            triggerMode: TooltipTriggerMode.tap,
            onTriggered: () async {
              Clipboard.setData(ClipboardData(
                      text:
                          "${subTitle ?? info?.artistName ?? info?.artist ?? ' ARtist name here'}"))
                  .then((_) {
                Get.snackbar("Copied",
                    "${subTitle ?? info?.artistName ?? info?.artist ?? ' ARtist name here'}",
                    backgroundColor: white,
                    duration: const Duration(seconds: 2));
              });

              print(
                  "Tapped text is ${title ?? info?.toneName ?? info?.contentName ?? ""}");
            },
            message: subTitle ??
                info?.artistName ??
                info?.artist ??
                ' ARtist name here',
            child: CustomText(
              maxLine: 1,
              overFlow: TextOverflow.ellipsis,
              title: subTitle ??
                  info?.artistName ??
                  info?.artist ??
                  ' ARtist name here',
              fontName: subTitleFontName ?? FontName.mediumItalic,
              fontSize: subTitleFontSize ?? 12,
              textColor: subTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
