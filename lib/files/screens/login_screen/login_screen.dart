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
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late BuildContext context;
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
    this.context = context;
    return Center(
        child: Material(color: Colors.transparent, child: popupContainer()));
  }

  Widget popupContainer() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          width: si.isMobile ? 300 : 550,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              closeButtonPopup(),
              paddingColumn(si),
            ],
          ),
        );
      },
    );
  }

  Widget paddingColumn(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 20 : 80),
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpacing(height: si.isMobile ? 10 : 20),
              logoImageWidget(si),
              vSpacing(height: si.isMobile ? 10 : 30),
              titleWidget(),
              vSpacing(height: 8),
              subTitleWidget(),
              vSpacing(height: si.isMobile ? 10 : 40),
              textfieldWidget(si),
              errorWidget(si),
              //vSpacing(height: 40),
              requestOtpButton(si),
              vSpacing(height: si.isMobile ? 10 : 20),
              termsAndConditionAgreement(),
              vSpacing(height: si.isMobile ? 10 : 50),
            ],
          );
        },
      ),
    );
  }

  Widget errorWidget(SizingInformation si) {
    return Obx(() {
      return controller.errorMessage.isEmpty
          ? SizedBox(
              height: si.isMobile ? 15 : 40,
            )
          : Padding(
              padding: EdgeInsets.only(bottom: si.isMobile ? 15 : 30, top: 5),
              child: ResponsiveBuilder(
                builder: (context, si) {
                  return CustomText(
                    title: controller.errorMessage.value,
                    fontName: FontName.regular,
                    textColor: blueLight,
                    fontSize: si.isMobile ? 10 : 16,
                  );
                },
              ),
            );
    });
  }

  Widget textfieldWidget(SizingInformation si) {
    return Obx(() {
      return CustomMsisdnTextField(
        height: si.isMobile ? 40 : 50,
        cornerRadius: si.isMobile ? 20 : 25,
        hintText: textFieldHint(),
        borderColor: textFieldBorderColorChange(),
        text: textFieldText(),
        addCountryCode: !controller.isMsisdnVarified.value,
        isMsisdn: !controller.isMsisdnVarified.value,
        onChanged: onChange,
        onSubmit: onSubmit,
      );
    });
  }

  String textFieldText() {
    return !controller.isMsisdnVarified.value
        ? controller.msisdn.value
        : controller.otp.value;
  }

  String textFieldHint() {
    return controller.isMsisdnVarified.value
        ? enter6DigitOtpStr
        : enterMobileNumberStr;
  }

  Color textFieldBorderColorChange() {
    return controller.isMsisdnVarified.value
        ? (controller.otp.value.length == StoreManager().otpLength
            ? blueLight
            : grey)
        : (controller.msisdn.value.length == StoreManager().msisdnLength
            ? blueLight
            : grey);
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
    return ResponsiveBuilder(
      builder: (context, si) {
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: signupAgreementStr,
                style: richTextStyle(si),
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
                    fontSize: si.isMobile ? 10 : 14,
                    color: blue,
                  )),
            ],
          ),
        );
      },
    );
  }

  TextStyle richTextStyle(SizingInformation si) {
    return TextStyle(
      fontFamily: FontName.light.name,
      fontSize: si.isMobile ? 10 : 14,
      color: black,
    );
  }

  Widget vSpacing({double height = 20}) {
    return SizedBox(height: height);
  }

  Widget closeButtonPopup() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: si.isMobile ? 2 : 10, right: si.isMobile ? 10 : 20),
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
      },
    );
  }

  Widget logoImageWidget(SizingInformation si) {
    return Image.asset(
      atomLogoBigImg,
      height: si.isMobile ? 30 : 50,
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
            fontSize: fontSize(14, 24),
          ),
        ],
      );
    });
  }

  Widget editNumber() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomButton(
          alignment: TextAlign.left,
          width: si.isMobile ? 30 : 40,
          onTap: () {
            controller.resetValue();
            print("Tapped back");
          },
          leftWidget: Icon(
            Icons.arrow_back,
            size: si.isMobile ? 18 : 25,
          ),
        );
      },
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
      return ResponsiveBuilder(
        builder: (context, si) {
          return CustomText(
            title: title,
            textColor: black,
            fontName: si.isMobile ? FontName.light : FontName.regular,
            fontSize: si.isMobile ? 10 : 14,
          );
        },
      );
    });
  }

  Widget requestOtpButton(SizingInformation si) {
    return Obx(() {
      return controller.isVerifying.value
          ? Center(child: loadingIndicator(radius: 12))
          : SizedBox(
              width: 250,
              child: ResponsiveBuilder(
                builder: (context, si) {
                  return CustomButton(
                    onTap: () async {
                      await onRequestButtonAction();
                    },
                    height: si.isMobile ? 40 : 50,
                    color: requestButtonColor(),
                    title: requestButtonTitle(),
                    fontName: si.isMobile ? FontName.medium : FontName.bold,
                    fontSize: si.isMobile ? 12 : 16,
                  );
                },
              ),
            );
    });
  }

  String requestButtonTitle() {
    return controller.isMsisdnVarified.value ? verifyOTPStr : requestOTPStr;
  }

  Color requestButtonColor() {
    return controller.isMsisdnVarified.value
        ? ((controller.otp.value.length == StoreManager().otpLength)
            ? blue
            : grey)
        : ((controller.msisdn.value.length == StoreManager().msisdnLength)
            ? blue
            : grey);
  }

  Future<void> onRequestButtonAction() async {
    if (controller.isMsisdnVarified.value) {
      bool isSuccess = await controller.verifyOtpButtonAction();
      if (isSuccess) {
        Get.back();
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 200));
        Get.dialog(
          Center(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                return CustomAlertView(
                    width: sizingInformation.isMobile ? 200 : 400,
                    title: successFullyLoggedInStr);
              },
            ),
          ),
        );
      }
    } else {
      controller.varifyMsisdnButtonAction();
    }
  }

  Future<void> onReqOtpAction() async {
    {
      if (controller.isMsisdnVarified.value) {
        controller.verifyOtpButtonAction();
        bool isSuccess = await controller.verifyOtpButtonAction();
        if (isSuccess) {
          Get.back();

          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 200));
          Get.dialog(
            Center(
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
