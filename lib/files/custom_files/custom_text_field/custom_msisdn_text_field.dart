import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class CustomMsisdnTextField extends StatelessWidget {
  final String hintText;
  final bool isMsisdn;
  final Widget? prefixWidget;
  final bool addCountryCode;

  const CustomMsisdnTextField({
    super.key,
    this.isMsisdn = true,
    this.prefixWidget,
    this.addCountryCode = true,
    this.hintText = enterMobileNumberStr,
  });
  @override
  Widget build(BuildContext context) {
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
              textColor: grey,
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
    return TextField(
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
