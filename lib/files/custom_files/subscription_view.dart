import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_prefrence.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SubscriptionView extends StatelessWidget {
  SubscriptionView({super.key, required this.info});
  late BuildContext context;
  final TuneInfo info;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
        color: transparent, child: Center(child: _popupContainer()));
  }

  Widget _popupContainer() {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topTilteAndCloseButtonWidget(),
              const SizedBox(height: 10),
              subscriptionInfo(),
              const SizedBox(height: 20),
              subscriptionListView(),
              const SizedBox(height: 20),
              tuneCharge(),
              const SizedBox(height: 20),
              buttonsWidget(),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget subscriptionInfo() {
    return const CustomText(
      title: youShouldSubscribeAPlanStr,
      fontName: FontName.ztlight,
      textColor: greyDark,
      fontSize: 14,
    );
  }

  Widget subscriptionListView() {
    List<String> titleList = ['50', '300', '1100'];
    List<String> subtitleList = ['Daily', 'Weekly', 'Monthly'];
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: subscriptionCell(
                greyLight, titleList[index], subtitleList[index]),
          );
        },
      ),
    );
  }

  Widget subscriptionCell(Color colors, String title, String subTitle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: colors,
      ),
      height: 120,
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: title,
            fontName: FontName.ztbold,
            fontSize: 28,
          ),
          CustomText(
            title: subTitle,
            fontName: FontName.abook,
            fontSize: 14,
          )
        ],
      ),
    );
  }

  Widget tuneCharge() {
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
                    title: info.toneName ?? '',
                    fontName: FontName.ztbold,
                    fontSize: 16,
                  ),
                  CustomText(
                    title: info.albumName ?? '',
                    fontName: FontName.abook,
                    fontSize: 14,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: tuneChargeStr,
                    fontName: FontName.abook,
                  ),
                  CustomText(
                    title: '320/month',
                    fontName: FontName.ztbold,
                    fontSize: 16,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonsWidget() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 30),
        Expanded(
          child: CustomButton(
            title: cancelStr,
            fontName: FontName.ztregular,
            borderColor: lightGreen,
            color: white,
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: CustomButton(
            title: confirmStr,
            fontName: FontName.ztregular,
            color: darkGreen,
            textColor: white,
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }

  Widget topTilteAndCloseButtonWidget() {
    return Container(
      color: greyLight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 50,
          ),
          const CustomText(
            title: chooseSubscriptionPlanStr,
            fontName: FontName.ztregular,
            textColor: greyDark,
          ),
          CustomButton(
            leftWidget: Icon(Icons.close),
            leftWidgetPadding: EdgeInsets.symmetric(horizontal: 8),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
