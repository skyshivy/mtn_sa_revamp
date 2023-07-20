import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/flies/utility/colors.dart';

import '../custom_text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? titlePadding;
  final Color? color;
  final Color? txtColor;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Color? textColor;
  final double? fontSize;
  final int? maxLine;
  final FontName? fontName;
  final TextAlign? alignment;
  final FontWeight? fontWeight;
  final MainAxisAlignment? mainAxisAlignment;
  final Function()? onTap;

  const CustomButton({
    super.key,
    this.height = 50,
    this.width,
    this.radius,
    this.color = transparent,
    this.title,
    this.textColor,
    this.fontSize,
    this.maxLine,
    this.fontName,
    this.alignment,
    this.fontWeight,
    this.mainAxisAlignment,
    this.leftWidget,
    this.rightWidget,
    this.titlePadding,
    this.txtColor,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration(),
        child: buttonRow(),
      ),
    );
  }

  Widget buttonRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: [
        leftWidget ?? const SizedBox(),
        (title == null) ? const SizedBox() : titleWidget(),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? height / 2));
  }

  Widget titleWidget() {
    return Padding(
      padding:
          (titlePadding == null) ? const EdgeInsets.all(0.0) : titlePadding!,
      child: CustomText(
        title: title ?? '',
        textColor: txtColor,
        fontSize: fontSize,
        fontName: fontName ?? FontName.regular,
        alignment: alignment,
        fontWeight: fontWeight,
      ),
    );
  }
}
