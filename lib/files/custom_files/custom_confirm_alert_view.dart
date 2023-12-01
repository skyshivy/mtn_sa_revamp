import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomConfirmAlertView extends StatelessWidget {
  final String? cancelTitle;
  final String? okTitle;
  final String message;
  final FontName fontName;
  final double? fontSize;
  final Function()? onOk;
  const CustomConfirmAlertView({
    super.key,
    this.cancelTitle,
    this.fontName = FontName.medium,
    this.fontSize,
    this.okTitle,
    required this.message,
    this.onOk,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            width: 500,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: ResponsiveBuilder(
                    builder: (context, si) {
                      return CustomText(
                        fontSize: fontSize ?? (si.isMobile ? null : 18),
                        alignment: TextAlign.center,
                        title: message.tr,
                        fontName: fontName,
                      );
                    },
                  ),
                ),
                Container(
                  color: grey,
                  height: 1,
                ),
                bottomSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSection(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          height: 45,
          color: white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // cancelTitle == null

              Visibility(
                visible: cancelTitle != null,
                child: Expanded(
                  child: CustomButton(
                    fontSize: si.isMobile ? null : 16,
                    color: white,
                    //fontName: si.isMobile ? FontName.medium : FontName.bold,
                    title: cancelStr.tr,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Visibility(
                visible: cancelTitle != null,
                child: Container(
                  height: 45,
                  width: 1,
                  color: grey,
                ),
              ),
              Expanded(
                child: CustomButton(
                  fontSize: si.isMobile ? null : 16,
                  color: white,
                  title: okTitle ?? okStr.tr,
                  //fontName: si.isMobile ? FontName.medium : FontName.bold,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onOk != null) {
                      onOk!();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
