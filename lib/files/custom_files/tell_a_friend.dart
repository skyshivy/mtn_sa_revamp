import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TellAFriendView extends StatelessWidget {
  const TellAFriendView({super.key, this.info});

  final TuneInfo? info;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: transparent,
      child: mainContaner(context),
    );
  }

  Widget mainContaner(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 30 : 0),
          child: Container(
            width: si.isMobile ? null : 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleContaner(context, si),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tuneImageWidget(),
                      const SizedBox(height: 15),
                      tuneDetail(),
                      const SizedBox(height: 10),
                      tuneCharge(),
                      const SizedBox(height: 4),
                      friendNumber(),
                      const SizedBox(height: 20),
                      buttonsWidget()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget titleContaner(BuildContext context, SizingInformation si) {
    return Container(
      height: 45,
      color: borderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: tellFriendStr,
              fontName: FontName.extraBold,
              fontSize: si.isMobile ? 14 : 18,
            ),
            CustomButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              leftWidget: Icon(Icons.close),
            )
          ],
        ),
      ),
    );
  }

  Widget tuneImageWidget() {
    return CustomImage(
      height: 150,
      radius: 8,
      url: info?.toneIdpreviewImageUrl,
    );
  }

  Widget tuneDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: info?.toneName ?? '',
          fontName: FontName.bold,
        ),
        CustomText(
          title: info?.albumName ?? '',
          fontName: FontName.medium,
          fontSize: 12,
        ),
      ],
    );
  }

  Widget friendNumber() {
    return CustomMsisdnTextField(height: 40, text: "");
  }

  Widget tuneCharge() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: tuneChargeStr,
          fontName: FontName.bold,
        ),
        CustomText(
          title: "312/30days",
          fontSize: 14,
        ),
      ],
    );
  }

  Widget buttonsWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? Column(
                children: [
                  cancelButton(),
                  const SizedBox(height: 8),
                  confirmButton()
                ],
              )
            : Row(
                children: [
                  Expanded(child: cancelButton()),
                  const SizedBox(width: 20),
                  Expanded(child: confirmButton()),
                ],
              );
      },
    );
  }

  CustomButton confirmButton() {
    return CustomButton(
      title: confirmStr,
      color: blue,
      textColor: white,
      fontName: FontName.bold,
    );
  }

  CustomButton cancelButton() {
    return CustomButton(
      title: cancelStr,
      fontName: FontName.bold,
      borderColor: atomCryan,
    );
  }
}
