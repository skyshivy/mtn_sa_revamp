import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/subscribe_plan_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SubscriptionView extends StatefulWidget {
  final TuneInfo info;

  const SubscriptionView({super.key, required this.info});
  @override
  State<StatefulWidget> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  //SubscriptionView({super.key, required this.info});
  late BuildContext context;
  BuyController bCont = Get.find();
  late SubscribePlanController sCont; // = Get.put(SubscribePlanController());
  @override
  void initState() {
    sCont = Get.put(SubscribePlanController());
    printCustom("initState SubscriptionView");
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SubscribePlanController>();
    printCustom("Dispose SubscriptionView");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
        color: transparent, child: Center(child: _popupContainer()));
  }

  Widget _popupContainer() {
    return ResponsiveBuilder(
      builder: (context, si) {
        this.context = context;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 30 : 0),
          child: mainContaner(si),
        );
      },
    );
  }

  Container mainContaner(SizingInformation si) {
    return Container(
      width: si.isMobile ? null : 550,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topTilteAndCloseButtonWidget(),
          const SizedBox(height: 10),
          subscriptionInfo(si),
          const SizedBox(height: 20),
          //specialOfferWidget(),
          subscriptionListView(),
          const SizedBox(height: 20),
          tuneCharge(si),
          const SizedBox(height: 20),
          buttonsWidget(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget specialOfferWidget() {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60), color: red),
          height: 120,
          width: 120,
          child: subscriptionCell(
            greyLight,
            "150",
            "special",
            0,
          ),
        ),
      ),
    );
  }

  Widget subscriptionInfo(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomText(
        alignment: TextAlign.center,
        title: youShouldSubscribeAPlanStr.tr,
        fontName: FontName.medium,
        textColor: subTitleColor,
        fontSize: si.isMobile ? 13 : 14,
      ),
    );
  }

  Widget subscriptionListView() {
    return SizedBox(
      height: 120,
      child: Obx(
        () {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: sCont.displayList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.only(right: 16, left: (index == 0) ? 20 : 0),
                child: subscriptionCell(
                  greyLight,
                  sCont.packChargeList[index],
                  sCont.displayList[index],
                  index,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget subscriptionCell(
      Color colors, String title, String subTitle, int index) {
    return InkWell(onTap: () {
      sCont.updateSelectedIndex(index);
      //sCont.tuneCharge.
      printCustom("cell tapped");
    }, child: Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: (sCont.selectedIndex.value == index) ? red : colors,
        ),
        height: 120,
        width: 120,
        child: cellColumn(title, subTitle),
      );
    }));
  }

  Padding cellColumn(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            alignment: TextAlign.center,
            title: title,
            fontName: FontName.extraBold,
            fontSize: 14,
          ),
          const SizedBox(height: 4),
          CustomText(
            alignment: TextAlign.center,
            title: subTitle,
            fontName: FontName.medium,
            fontSize: 14,
          )
        ],
      ),
    );
  }

  Widget tuneCharge(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: greyLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: widget.info.toneName ?? '',
                    fontName: FontName.bold,
                    fontSize: si.isMobile ? 13 : 16,
                  ),
                  CustomText(
                    title: widget.info.albumName ?? '',
                    fontName: FontName.medium,
                    fontSize: si.isMobile ? 12 : 14,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: tuneChargeStr.tr,
                    fontName: FontName.medium,
                    fontSize: si.isMobile ? 13 : 16,
                  ),
                  Obx(() {
                    return CustomText(
                      title: bCont.tuneCharge.value,
                      fontName: FontName.bold,
                      fontSize: si.isMobile ? 13 : 16,
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonsWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile ? mobileButtonColumn() : buttonRowWidget();
      },
    );
  }

  Row buttonRowWidget() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: cancelButton(),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: confirmButton(),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  Padding mobileButtonColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [confirmButton(), const SizedBox(height: 10), cancelButton()],
      ),
    );
  }

  Widget confirmButton() {
    return Obx(() {
      return CustomButton(
        title: confirmStr.tr,
        fontName: FontName.medium,
        color: sCont.enableSubmitButton.value ? blue : grey,
        textColor: sCont.enableSubmitButton.value ? white : black,
        onTap: () {
          if (sCont.enableSubmitButton.value) {
            bCont.onConfirmSubscriptionPlan(
                sCont.packList[sCont.selectedIndex.value]);
          }
        },
      );
    });
  }

  CustomButton cancelButton() {
    return CustomButton(
      title: cancelStr.tr,
      fontName: FontName.medium,
      borderColor: atomCryan,
      color: white,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget topTilteAndCloseButtonWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: greyLight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 50,
              ),
              Flexible(
                child: CustomText(
                  title: chooseSubscriptionPlanStr.tr,
                  fontName: si.isMobile ? FontName.bold : FontName.bold,
                  textColor: black,
                  fontSize: si.isMobile ? 14 : null,
                ),
              ),
              CustomButton(
                leftWidget: const Icon(Icons.close),
                leftWidgetPadding: const EdgeInsets.symmetric(horizontal: 8),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
