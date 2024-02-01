import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/otp_timer_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';

import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class BuyOtpView extends StatefulWidget {
  const BuyOtpView({super.key});

  @override
  State<StatefulWidget> createState() => _BuyOtpViewState();
}

class _BuyOtpViewState extends State<BuyOtpView> {
  BuyController buyController = Get.find();

  @override
  void initState() {
    //otpController = Get.put(OtpTimerController());
    otpController.initTimer();
    super.initState();
  }

  @override
  void dispose() {
    //Get.delete<OtpTimerController>();
    otpController.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(color: transparent, child: popupContainer());
  }

  Widget popupContainer() {
    return Center(
      child: ResponsiveBuilder(
        builder: (context, si) {
          return Container(
            width: si.isMobile ? 300 : 500,
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
      ),
    );
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

                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget paddingColumn(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 20 : 40),
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
              textfieldWidget(si),
              errorWidget(si),
              resentOtpButton(),
              requestOtpButton(si),
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
          padding: const EdgeInsets.only(top: 10),
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

  Widget textfieldWidget(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Obx(() {
        return CustomMsisdnTextField(
          enabled: !buyController.isVerifyingOtp.value,
          height: si.isMobile ? 40 : 44,
          cornerRadius: si.isMobile ? 20 : 22,
          hintText: enter6DigitOtpStr.tr,
          borderColor: textFieldBorderColorChange(),
          text: buyController.otp.value,
          addCountryCode: false,
          isMsisdn: false,
          onChanged: onChange,
          onSubmit: onSubmit,
        );
      }),
    );
  }

  void onChange(String value) {
    printCustom("Otp length ==== ${value.length}");
    buyController.updateOtp(value);

    buyController.otp.value = value;
  }

  void onSubmit(String value) async {
    buyController.verifyingOtpCheck();
    buyController.otp.value = value;

    printCustom("On submitted   ==========$value");
  }

  Color textFieldBorderColorChange() {
    return (buyController.otp.value.length == StoreManager().otpLength
        ? atomCryan
        : grey);
  }

  Widget errorWidget(SizingInformation si) {
    return Obx(() {
      return Visibility(
        visible: buyController.errorMessage.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ResponsiveBuilder(
            builder: (context, si) {
              return CustomText(
                title: buyController.errorMessage.value,
                fontName: FontName.medium,
                textColor: red,
                fontSize: si.isMobile ? 10 : 16,
              );
            },
          ),
        ),
      );
    });
  }

  Widget vSpacing({double height = 20}) {
    return SizedBox(height: height);
  }

  Widget logoImageWidget(SizingInformation si) {
    return Image.asset(
      atomLogoBigImg,
      height: si.isMobile ? 30 : 50,
    );
  }

  Widget titleWidget() {
    String title = enter6DigitOtpStr.tr;
    return ResponsiveBuilder(
      builder: (context, si) {
        return Row(
          children: [
            // CustomButton(
            //   title: editStr,
            //   onTap: () {
            //     buyController.onEditAction();
            //   },
            // ),
            CustomText(
              title: title,
              fontName: FontName.bold,
              fontSize: si.isMobile ? 14 : 24,
            ),
          ],
        );
      },
    );
  }

  Widget subTitleWidget() {
    // ignore: prefer_interpolation_to_compose_strings
    var title = oneTimePasswordHasBeenSentStr.tr +
        ' ' +
        countryCodeStr.tr +
        "-" +
        "${buyController.msisdn}";

    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomText(
          title: title,
          textColor: black,
          fontName: si.isMobile ? FontName.light : FontName.medium,
          fontSize: si.isMobile ? 10 : 14,
        );
      },
    );
  }

  Widget requestOtpButton(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Obx(() {
        return buyController.isVerifyingOtp.value
            ? Center(child: loadingIndicator(radius: 12))
            : SizedBox(
                width: 250,
                child: ResponsiveBuilder(
                  builder: (context, si) {
                    return Obx(() {
                      return CustomButton(
                        textColor: white,
                        onTap: () async {
                          buyController.verifyingOtpCheck();
                        },
                        height: si.isMobile ? 40 : 44,
                        color: requestButtonColor(),
                        title: requestButtonTitle(),
                        fontName: si.isMobile ? FontName.medium : FontName.bold,
                        fontSize: si.isMobile ? 12 : 16,
                      );
                    });
                  },
                ),
              );
      }),
    );
  }

  String requestButtonTitle() {
    return verifyOTPStr.tr;
  }

  Color requestButtonColor() {
    (buyController.otp.value.length == StoreManager().otpLength
        ? atomCryan
        : grey);
    return ((buyController.otp.value.length == StoreManager().otpLength)
        ? blue
        : grey);
  }
}
