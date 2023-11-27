import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

import '../custom_text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double height;
  final double borderWidth;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? leftWidgetPadding;
  final EdgeInsetsGeometry mainPadding;
  final Color? color;
  final Color? borderColor;

  final Widget? leftWidget;
  final Widget? rightWidget;
  final Color? textColor;
  final double? fontSize;
  final int? maxLine;
  final FontName? fontName;
  final TextAlign? alignment;

  final MainAxisAlignment? mainAxisAlignment;
  final Function()? onTap;

  const CustomButton({
    super.key,
    this.height = 40,
    this.borderWidth = 1,
    this.width,
    this.radius,
    this.color = transparent,
    this.title,
    this.textColor,
    this.mainPadding = const EdgeInsets.all(0),
    this.fontSize,
    this.maxLine,
    this.fontName,
    this.alignment,
    this.mainAxisAlignment,
    this.leftWidget,
    this.rightWidget,
    this.titlePadding,
    this.leftWidgetPadding,
    this.onTap,
    this.borderColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: transparent,
      hoverColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration(),
        child: Padding(
          padding: mainPadding,
          child: buttonRow(),
        ),
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        Padding(
          padding: leftWidgetPadding ?? const EdgeInsets.all(0),
          child: leftWidget ?? const SizedBox(),
        ),
        (title == null)
            ? const SizedBox()
            : (title!.isEmpty ? const SizedBox() : titleWidget()),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: color,
        border:
            Border.all(color: borderColor ?? transparent, width: borderWidth),
        borderRadius: BorderRadius.circular(radius ?? height / 2));
  }

  Widget titleWidget() {
    return Padding(
      padding:
          (titlePadding == null) ? const EdgeInsets.all(0.0) : titlePadding!,
      child: CustomText(
        title: (title ?? '').tr,
        textColor: textColor,
        fontSize: fontSize,
        fontName: fontName ?? FontName.medium,
        alignment: alignment,
      ),
    );
  }
}
