import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class CustomMsisdnTextField extends StatelessWidget {
  final String text;
  final String? hintText;
  final bool isMsisdn;
  final Color borderColor;
  final Color bgColor;
  final Widget? rightWidget;
  final Color countryCodeColor;
  final double cornerRadius;
  final Widget? prefixWidget;
  final bool addCountryCode;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final TextEditingController textEditingController = TextEditingController();
  CustomMsisdnTextField({
    super.key,
    this.isMsisdn = true,
    this.prefixWidget,
    this.cornerRadius = 25,
    this.countryCodeColor = greyDark,
    this.bgColor = transparent,
    this.rightWidget,
    this.addCountryCode = true,
    this.hintText = enterMobileNumberStr,
    this.onChanged,
    this.onSubmit,
    required this.text,
    this.borderColor = grey,
  });
  @override
  Widget build(BuildContext context) {
    textEditingController.text = text;
    return Container(
      height: 50,
      decoration: mainDecoration(),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          prefixContainerWidget(),
          Expanded(child: textField()),
          rightWidget ?? const SizedBox()
        ],
      )),
    );
  }

  Widget prefixContainerWidget() {
    return prefixWidget ??
        (addCountryCode ? countryCode() : const SizedBox(width: 20));
  }

  Widget countryCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: addCountryCode
          ? CustomText(
              title: countryCodeStr,
              fontName: FontName.regular,
              textColor: countryCodeColor,
              fontSize: fontSize(14, 18),
            )
          : const SizedBox(width: 10),
    );
  }

  BoxDecoration mainDecoration() {
    return BoxDecoration(
      //color: yellow,
      color: bgColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(cornerRadius),
    );
  }

  Widget textField() {
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    return TextField(
      controller: textEditingController,

      onSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChanged!(value);
      },
      style: TextStyle(
          fontFamily: FontName.regular.name, fontSize: fontSize(14, 18)),
      decoration: inputDecoration(),
      keyboardType: TextInputType.phone,

      inputFormatters: inputFormate, // Only numbers can be entered
    );
  }

  List<TextInputFormatter> get inputFormate {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(
          isMsisdn ? StoreManager().msisdnLength : StoreManager().otpLength),
    ];
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      border: InputBorder.none,
    );
  }
}
