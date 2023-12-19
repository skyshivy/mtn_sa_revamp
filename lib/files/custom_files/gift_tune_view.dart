import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/gift_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GiftTuneView extends StatefulWidget {
  final TuneInfo info;

  const GiftTuneView({super.key, required this.info});

  @override
  State<StatefulWidget> createState() => _GiftTuneViewState();
}

class _GiftTuneViewState extends State<GiftTuneView> {
  late GiftTuneController cont;
  @override
  void initState() {
    cont = Get.put(GiftTuneController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<GiftTuneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return cont.isSendDone.value
          ? CustomAlertView(title: cont.errorMessage.value)
          : Material(
              color: transparent,
              child: mainContaner(context),
            );
    });
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
            child: mainColumn(context, si),
          ),
        );
      },
    );
  }

  Column mainColumn(BuildContext context, SizingInformation si) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        titleContaner(context, si),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: bottomContainerColunm(context, si),
        )
      ],
    );
  }

  Column bottomContainerColunm(BuildContext context, SizingInformation si) {
    return Column(
      mainAxisAlignment:
          si.isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        tuneImageWidget(si),
        const SizedBox(height: 15),
        tuneDetail(si),
        const SizedBox(height: 10),
        tuneCharge(),
        const SizedBox(height: 4),
        friendNumber(),
        errorMessageWidget(),
        const SizedBox(height: 20),
        buttonsWidget(context)
      ],
    );
  }

  Widget errorMessageWidget() {
    return Obx(() {
      return Visibility(
        visible: cont.errorMessage.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CustomText(
            title: cont.errorMessage.value,
            textColor: red,
            fontSize: 12,
          ),
        ),
      );
    });
  }

  Widget titleContaner(BuildContext context, SizingInformation si) {
    return Container(
      height: 45,
      color: borderColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [titleWidget(si), closeButtonWidget(context)],
        ),
      ),
    );
  }

  CustomButton closeButtonWidget(BuildContext context) {
    return CustomButton(
      onTap: () {
        Navigator.of(context).pop();
      },
      leftWidget: Icon(Icons.close),
    );
  }

  CustomText titleWidget(SizingInformation si) {
    return CustomText(
      title: giftStr,
      fontName: FontName.aheavy,
      fontSize: si.isMobile ? 14 : 18,
    );
  }

  Widget tuneImageWidget(SizingInformation si) {
    return SizedBox(
      width: si.isMobile ? 150 : null,
      child: CustomImage(
        height: 150,
        url: widget.info.toneIdpreviewImageUrl,
      ),
    );
  }

  Widget tuneDetail(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        tuneTitle(si),
        tuneSubtitle(si),
      ],
    );
  }

  CustomText tuneSubtitle(SizingInformation si) {
    return CustomText(
      alignment: si.isMobile ? TextAlign.center : null,
      title: widget.info.albumName ?? '',
      fontName: FontName.ztregular,
      fontSize: 12,
    );
  }

  CustomText tuneTitle(SizingInformation si) {
    return CustomText(
      alignment: si.isMobile ? TextAlign.center : null,
      title: widget.info.toneName ?? '',
      fontName: FontName.aheavy,
    );
  }

  Widget friendNumber() {
    return Obx(() {
      return CustomMsisdnTextField(
        hintText: pleaseEnterFriendNumberStr,
        enabled: !cont.isVerifing.value,
        height: 40,
        text: cont.bPartyMsisdn.value,
        onChanged: (p0) {
          cont.updateMsisdn(p0);
        },
        onSubmit: (p0) {
          cont.confirmButtonAction(widget.info);
        },
      );
    });
  }

  Widget tuneCharge() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [tuneChargeTitle(), tuneChargeWidget()],
    );
  }

  CustomText tuneChargeWidget() {
    return CustomText(
      title: cont.tuneCharge,
      fontSize: 14,
    );
  }

  CustomText tuneChargeTitle() {
    return CustomText(
      title: tuneChargeStr,
      fontName: FontName.aheavy,
    );
  }

  Widget buttonsWidget(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? Column(
                children: [
                  cancelButton(context),
                  const SizedBox(height: 8),
                  confirmButton()
                ],
              )
            : Row(
                children: [
                  Expanded(child: cancelButton(context)),
                  const SizedBox(width: 20),
                  Expanded(child: confirmButton()),
                ],
              );
      },
    );
  }

  Widget confirmButton() {
    return Obx(() {
      return cont.isVerifing.value
          ? loadingIndicator(radius: 10)
          : CustomButton(
              title: confirmStr,
              color: darkGreen,
              textColor: white,
              fontName: FontName.aheavy,
              onTap: () {
                cont.confirmButtonAction(widget.info);
              },
            );
    });
  }

  CustomButton cancelButton(BuildContext context) {
    return CustomButton(
      title: cancelStr,
      fontName: FontName.aheavy,
      borderColor: lightGreen,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
