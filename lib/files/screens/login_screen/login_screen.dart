// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/otp_timer_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';

import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../custom_files/custom_print.dart';

late OtpTimerController otpController; // = Get.put(OtpTimerController());

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
    //otpController = Get.find(); //(OtpTimerController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    otpController.cancelTimer();
    //Get.delete<OtpTimerController>();
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
        return Scaffold(
          backgroundColor: transparent,
          body: Center(
            child: Container(
              width: si.isMobile ? 300 : 550,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: white),
              child: ListView(
                shrinkWrap: true,
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  closeButtonPopup(),
                  paddingColumn(si),
                ],
              ),
            ),
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
              Obx(() {
                return controller.isMsisdnVarified.value
                    ? resentOtpButton()
                    : const SizedBox();
              }),
              //vSpacing(height: 40),
              requestOtpButton(si),
              vSpacing(height: si.isMobile ? 10 : 20),
              //termsAndConditionAgreement(),
              vSpacing(height: si.isMobile ? 10 : 50),
            ],
          );
        },
      ),
    );
  }

  Widget resentOtpButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Obx(() {
            return otpController.isLoading.value
                ? SizedBox(
                    width: 100, child: loadingIndicator(height: 40, radius: 10))
                : CustomButton(
                    textColor: atomCryan,
                    fontName: FontName.medium,
                    title:
                        "${otpController.isRunning.value ? sentOtpInTimeStr.tr : sentOtpStr.tr} "
                        " ${otpController.timeLeft.value}",
                    onTap: () {
                      otpController.startTimer();
                      printCustom("resent otp ");
                    },
                  );
          }),
        ),
      ],
    );
  }

  Widget errorWidget(SizingInformation si) {
    return Obx(() {
      return controller.errorMessage.isEmpty
          ? SizedBox(
              height: si.isMobile ? 15 : 10,
            )
          : Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: ResponsiveBuilder(
                builder: (context, si) {
                  return CustomText(
                    title: controller.errorMessage.value,
                    fontName: FontName.medium,
                    textColor: red,
                    fontSize: si.isMobile ? 13 : 16,
                  );
                },
              ),
            );
    });
  }

  Widget textfieldWidget(SizingInformation si) {
    return AutofillGroup(
      child: Obx(() {
        return CustomMsisdnTextField(
          autoFillHint: const [AutofillHints.telephoneNumber],
          height: si.isMobile ? 40 : 44,
          cornerRadius: si.isMobile ? 20 : 22,
          hintText: textFieldHint(),
          borderColor: textFieldBorderColorChange(),
          text: textFieldText(),
          addCountryCode: !controller.isMsisdnVarified.value,
          isMsisdn: !controller.isMsisdnVarified.value,
          onChanged: onChange,
          onSubmit: onSubmit,
        );
      }),
    );
  }

  String textFieldText() {
    return !controller.isMsisdnVarified.value
        ? controller.msisdn.value
        : controller.otp.value;
  }

  String textFieldHint() {
    return controller.isMsisdnVarified.value
        ? enter6DigitOtpStr.tr
        : enterMobileNumberStr.tr;
  }

  Color textFieldBorderColorChange() {
    return controller.isMsisdnVarified.value
        ? (controller.otp.value.length == StoreManager().otpLength
            ? atomCryan
            : grey)
        : (controller.msisdn.value.length == StoreManager().msisdnLength
            ? atomCryan
            : grey);
  }

  void onChange(String value) {
    controller.editMsisdn();
    if (controller.isMsisdnVarified.value) {
      controller.otp.value = value;
    } else {
      controller.msisdn.value = value;
    }

    printCustom("On change ======$value");
  }

  void onSubmit(String value) async {
    if (controller.isMsisdnVarified.value) {
      controller.otp.value = value;
      bool _ = await controller.verifyOtpButtonAction();
      printCustom("Login Screen \n onSubmit method  123\n");
    } else {
      controller.varifyMsisdnButtonAction();
      controller.msisdn.value = value;
    }
    printCustom("On submitted   ==========$value");
  }

  Widget termsAndConditionAgreement() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: signupAgreementStr.tr,
                style: richTextStyle(si),
              ),
              TextSpan(
                  onEnter: (event) {
                    printCustom("You just hovered on text");
                  },
                  onExit: (event) {
                    printCustom("You just exit from hovered");
                  },
                  text: termsAndPolicyStr.tr,
                  style: TextStyle(
                    fontFamily: FontName.medium.name,
                    fontSize: si.isMobile ? 12 : 14,
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
      fontSize: si.isMobile ? 12 : 14,
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
                  printCustom("CLose button tapped");
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
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          String title = controller.isMsisdnVarified.value
              ? enter6DigitOtpStr.tr
              : signInToYourAccountStr.tr;
          return Row(
            children: [
              controller.isMsisdnVarified.value
                  ? editNumber()
                  : const SizedBox(),
              CustomText(
                title: title,
                fontName: FontName.bold,
                fontSize: si.isMobile ? 16 : 24,
              ),
            ],
          );
        });
      },
    );
  }

  Widget editNumber() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomButton(
            alignment: TextAlign.left,
            width: si.isMobile ? 30 : 40,
            onTap: () {
              controller.resetValue();
              printCustom("Tapped back");
            },
            leftWidget: Image.asset(
              arrowBackImg,
              width: si.isMobile ? 18 : 25,
            )
            // Icon(
            //   Icons.arrow_back,
            //   size: si.isMobile ? 18 : 25,
            // ),
            );
      },
    );
  }

  Widget subTitleWidget() {
    return Obx(() {
      var title = controller.isMsisdnVarified.value
          ? oneTimePasswordHasBeenSentStr.tr +
              ' ' +
              countryCodeStr.tr +
              "-" +
              "${controller.msisdn}"
          : pleaseEnterYourMobileNumberInOrderToAuthenticateStr.tr;
      return ResponsiveBuilder(
        builder: (context, si) {
          return CustomText(
            title: title,
            textColor: black,
            fontName: si.isMobile ? FontName.medium : FontName.medium,
            fontSize: si.isMobile ? 12 : 14,
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
                  return Obx(() {
                    return CustomButton(
                      onTap: () async {
                        await onRequestButtonAction();
                      },
                      height: si.isMobile ? 40 : 44,
                      color: requestButtonColor(),
                      textColor: white,
                      title: requestButtonTitle(),
                      fontName: si.isMobile ? FontName.medium : FontName.bold,
                      fontSize: si.isMobile ? 14 : 16,
                    );
                  });
                },
              ),
            );
    });
  }

  String requestButtonTitle() {
    return controller.isMsisdnVarified.value
        ? verifyOTPStr.tr
        : requestOTPStr.tr;
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
      printCustom("Login Screen \n onRequestButtonAction  135\n");
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
                    title: successFullyLoggedInStr.tr);
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
        await controller.verifyOtpButtonAction();
        bool isSuccess = await controller.verifyOtpButtonAction();
        printCustom("Login Screen \n onReqOtpAction method  135\n");
        printCustom("Verufied l and called in Login screen");
        if (isSuccess) {
          printCustom("Verufied l and called in Login screen is success");
          Get.back();

          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 200));
          Get.dialog(
            Center(
              child: CustomAlertView(title: successFullyLoggedInStr.tr),
            ),
          );
        }
      } else {
        controller.varifyMsisdnButtonAction();
      }
    }
  }
}
