import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Material(color: transparent, child: popupContainer()));
  }

  Widget popupContainer() {
    return Container(
      width: 600,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          closeButtonPopup(),
          paddingColumn(),
        ],
      ),
    );
  }

  Widget paddingColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSpacing(),
          logoImageWidget(),
          vSpacing(height: 30),
          titleWidget(),
          vSpacing(height: 8),
          subTitleWidget(),
          vSpacing(height: 40),
          vSpacing(height: 40),
          requestOtpButton(),
        ],
      ),
    );
  }

  Widget vSpacing({double height = 20}) {
    return SizedBox(height: height);
  }

  Widget closeButtonPopup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 20),
          child: CustomButton(
            leftWidget: const Icon(Icons.close),
            onTap: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  Widget logoImageWidget() {
    return Image.asset(
      logoBigImg,
      height: 60,
    );
  }

  Widget titleWidget() {
    return CustomText(
      title: signInToYourAccountStr,
      fontName: FontName.bold,
      fontSize: fontSize(16, 24),
    );
  }

  Widget subTitleWidget() {
    return CustomText(
      title: pleaseEnterYourMobileNumberInOrderToAuthenticateStr,
      fontName: fontName(FontName.regular, FontName.light),
      fontSize: 14,
    );
  }

  Widget requestOtpButton() {
    return SizedBox(
      width: 200,
      child: CustomButton(
        height: 50,
        color: greyLight,
        title: requestOTPStr,
        fontName: FontName.bold,
        fontSize: fontSize(12, 16),
      ),
    );
  }
}
