import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tell_freind_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TellAFriendView extends StatefulWidget {
  final TuneInfo? info;

  const TellAFriendView({super.key, this.info});

  @override
  State<StatefulWidget> createState() => _TellAFriendViewState();
}

class _TellAFriendViewState extends State<TellAFriendView> {
  late TellFriendController cont;
  @override
  void initState() {
    cont = Get.put(TellFriendController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<TellFriendController>();
    super.dispose();
  }

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
          child: bottomContainerColunm(context),
        )
      ],
    );
  }

  Column bottomContainerColunm(BuildContext context) {
    return Column(
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
      title: tellFriendStr,
      fontName: FontName.extraBold,
      fontSize: si.isMobile ? 14 : 18,
    );
  }

  Widget tuneImageWidget() {
    return CustomImage(
      height: 150,
      radius: 8,
      url: widget.info?.toneIdpreviewImageUrl,
    );
  }

  Widget tuneDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tuneTitle(),
        tuneSubtitle(),
      ],
    );
  }

  CustomText tuneSubtitle() {
    return CustomText(
      title: widget.info?.albumName ?? '',
      fontName: FontName.mediumItalic,
      fontSize: 12,
    );
  }

  CustomText tuneTitle() {
    return CustomText(
      title: widget.info?.toneName ?? '',
      fontName: FontName.bold,
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
          cont.confirmButtonAction(widget.info ?? TuneInfo());
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
      fontName: FontName.bold,
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
              color: blue,
              textColor: white,
              fontName: FontName.bold,
              onTap: () {
                cont.confirmButtonAction(widget.info ?? TuneInfo());
              },
            );
    });
  }

  CustomButton cancelButton(BuildContext context) {
    return CustomButton(
      title: cancelStr,
      fontName: FontName.bold,
      borderColor: atomCryan,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
