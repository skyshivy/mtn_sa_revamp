import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final bool? isBorder;
  final Color? cursorColor;
  final Color? textColor;
  final Color? bgColor;
  final Color? hintColor;
  final double? fontSize;
  final double hPadding;
  final double? radius;
  final bool? editEnable;
  final FontName fontName;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmit;
  TextEditingController controller = TextEditingController();

  CustomTextField({
    super.key,
    this.bgColor = transparent,
    this.isBorder = true,
    required this.text,
    this.cursorColor,
    this.onChanged,
    this.onTap,
    this.hPadding = 22,
    this.onSubmit,
    this.textColor,
    this.fontSize = 14,
    this.hintText = pleaseEnterMsisdn,
    this.hintColor = textFieldPlaceHolderColor,
    this.fontName = FontName.abook,
    this.editEnable,
    this.radius,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: bgColor,
          border: isBorder! ? Border.all(color: greyDark) : null,
          borderRadius: BorderRadius.circular(radius ?? 25),
        ),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: textField(),
        )));
  }

  TextField textField() {
    controller.text = text;
    return TextField(
      textInputAction: TextInputAction.done,
      enabled: editEnable,
      autocorrect: false,
      enableSuggestions: false,
      controller: textEditingController(),
      cursorColor: cursorColor,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      onTap: onTap,
      decoration: inputDecoration(),
      style: textStyle(),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontFamily: fontName.name,
      color: textColor,
      fontSize: fontSize,
    );
  }

  TextEditingController textEditingController() {
    return TextEditingController.fromValue(
      TextEditingValue(
          text: text,
          selection: TextSelection(
            baseOffset: text.length,
            extentOffset: text.length,
          )),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: hintColor),
      isDense: true,
      border: InputBorder.none,
    );
  }
}
