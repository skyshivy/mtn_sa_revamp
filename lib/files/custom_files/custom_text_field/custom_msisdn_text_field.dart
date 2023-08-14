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
  final Widget? prefixWidget;
  final bool addCountryCode;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final TextEditingController textEditingController = TextEditingController();
  CustomMsisdnTextField({
    super.key,
    this.isMsisdn = true,
    this.prefixWidget,
    this.addCountryCode = true,
    this.hintText = enterMobileNumberStr,
    this.onChanged,
    this.onSubmit,
    required this.text,
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: addCountryCode
          ? CustomText(
              title: countryCodeStr,
              fontName: FontName.regular,
              textColor: greyDark,
              fontSize: fontSize(14, 18),
            )
          : const SizedBox(width: 10),
    );
  }

  BoxDecoration mainDecoration() {
    return BoxDecoration(
      //color: yellow,
      border: Border.all(color: grey),
      borderRadius: BorderRadius.circular(25),
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
