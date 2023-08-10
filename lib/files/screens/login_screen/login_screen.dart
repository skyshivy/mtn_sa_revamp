// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(color: Colors.transparent, child: popupContainer()));
  }

  Widget popupContainer() {
    return Container(
      width: 550,
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
          textfieldWidget(),
          errorWidget(),
          //vSpacing(height: 40),
          requestOtpButton(),
          vSpacing(height: 20),
          termsAndConditionAgreement(),
          vSpacing(height: 50),
        ],
      ),
    );
  }

  Widget errorWidget() {
    return Obx(() {
      return controller.errorMessage.isEmpty
          ? const SizedBox(
              height: 40,
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 5),
              child: CustomText(
                title: controller.errorMessage.value,
                fontName: FontName.regular,
                textColor: red,
              ),
            );
    });
  }

  Widget textfieldWidget() {
    return Obx(() {
      return CustomMsisdnTextField(
        hintText: controller.isMsisdnVarified.value ? enter6DigitOtpStr : null,
        text: !controller.isMsisdnVarified.value
            ? controller.msisdn.value
            : controller.otp.value,
        addCountryCode: !controller.isMsisdnVarified.value,
        isMsisdn: !controller.isMsisdnVarified.value,
        onChanged: onChange,
        onSubmit: onSubmit,
      );
    });
  }

  void onChange(String value) {
    controller.editMsisdn();
    if (controller.isMsisdnVarified.value) {
      controller.otp.value = value;
    } else {
      controller.msisdn.value = value;
    }

    print("On change ======$value");
  }

  void onSubmit(String value) async {
    if (controller.isMsisdnVarified.value) {
      controller.otp.value = value;
      controller.verifyOtpButtonAction();
    } else {
      controller.varifyMsisdnButtonAction();
      controller.msisdn.value = value;
    }
    print("On submitted   ==========$value");
  }

  Widget termsAndConditionAgreement() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: signupAgreementStr,
            style: TextStyle(
                fontFamily: FontName.light.name,
                fontSize: fontSize(14, 14),
                color: black),
          ),
          TextSpan(
              onEnter: (event) {
                print("You just hovered on text");
              },
              onExit: (event) {
                print("You just exit from hovered");
              },
              text: termsAndPolicyStr,
              style: TextStyle(
                fontFamily: FontName.regular.name,
                fontSize: fontSize(14, 14),
                color: yellow,
              )),
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
              print("CLose button tapped");
              Get.back();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget logoImageWidget() {
    return Image.asset(
      logoBigImg,
      height: 50,
    );
  }

  Widget titleWidget() {
    return Obx(() {
      String title = controller.isMsisdnVarified.value
          ? enter6DigitOtpStr
          : signInToYourAccountStr;
      return Row(
        children: [
          controller.isMsisdnVarified.value ? editNumber() : const SizedBox(),
          CustomText(
            title: title,
            fontName: FontName.bold,
            fontSize: fontSize(16, 24),
          ),
        ],
      );
    });
  }

  Widget editNumber() {
    return CustomButton(
      width: 40,
      onTap: () {
        controller.resetValue();
        print("Tapped back");
      },
      leftWidget: const Icon(
        Icons.arrow_back,
        size: 25,
      ),
    );
  }

  Widget subTitleWidget() {
    return Obx(() {
      var title = controller.isMsisdnVarified.value
          ? oneTimePasswordHasBeenSentStr +
              ' ' +
              countryCodeStr +
              "-" +
              "${controller.msisdn}"
          : pleaseEnterYourMobileNumberInOrderToAuthenticateStr;
      return CustomText(
        title: title,
        textColor: black,
        fontName: fontName(FontName.regular, FontName.light),
        fontSize: 14,
      );
    });
  }

  Widget requestOtpButton() {
    return Obx(() {
      return controller.isVerifying.value
          ? Center(child: loadingIndicator(radius: 12))
          : SizedBox(
              width: 250,
              child: CustomButton(
                onTap: () async {
                  if (controller.isMsisdnVarified.value) {
                    bool isSuccess = await controller.verifyOtpButtonAction();
                    if (isSuccess) {
                      Get.back();
                      await Future.delayed(const Duration(milliseconds: 200));
                      Get.dialog(
                        const Center(
                          child:
                              CustomAlertView(title: successFullyLoggedInStr),
                        ),
                      );
                    }
                  } else {
                    controller.varifyMsisdnButtonAction();
                  }
                },
                height: 50,
                color: greyLight,
                title: controller.isMsisdnVarified.value
                    ? verifyOTPStr
                    : requestOTPStr,
                fontName: FontName.bold,
                fontSize: fontSize(12, 16),
              ),
            );
    });
  }

  Future<void> onReqOtpAction() async {
    {
      if (controller.isMsisdnVarified.value) {
        controller.verifyOtpButtonAction();
        bool isSuccess = await controller.verifyOtpButtonAction();
        if (isSuccess) {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          Get.dialog(
            const Center(
              child: CustomAlertView(title: successFullyLoggedInStr),
            ),
          );
        }
      } else {
        controller.varifyMsisdnButtonAction();
      }
    }
  }
}
