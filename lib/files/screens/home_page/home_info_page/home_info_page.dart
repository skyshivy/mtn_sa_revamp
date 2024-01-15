import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingInfoPage extends StatelessWidget {
  const LandingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          //  height: isPhone(context) ? 250 : 500,
          color: atomCryan,
          child: Image.asset(si.isMobile
              ? bottomBannerMobilePng
              : bottomBannerWebPng), //mainRow(context),
        );
      },
    );
  }

  Row mainRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isPhone(context)
            ? const SizedBox(
                width: 20,
              )
            : Flexible(child: leftImageWidget()),
        Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            expressWidget(),
            infoDot(homeInfo1.tr),
            infoDot(homeInfo2.tr),
            infoDot(homeInfo3.tr),
            infoDot(homeInfo4.tr),
            infoDot(homeInfo5.tr),
            infoDot(homeInfo6.tr),
          ],
        )),
      ],
    );
  }

  CustomText expressWidget() {
    return CustomText(
      title: express.tr,
      fontName: FontName.bold,
      fontSize: fontSize(20, 50),
    );
  }

  Widget leftImageWidget() {
    return Image.asset(
      tuneMoodImg,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget infoDot(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dotWidget(),
          const SizedBox(width: 4),
          Expanded(child: textWidget(title)),
        ],
      ),
    );
  }

  CustomText textWidget(String title) {
    return CustomText(
      title: title,
      fontName: FontName.medium,
      fontSize: fontSize(14, 24),
    );
  }

  Padding dotWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black,
        ),
      ),
    );
  }
}
