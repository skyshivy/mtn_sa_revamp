import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/files/screens/home_page/home_page_bottom_section/sub_views/landing_company_view.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_page_bottom_section/sub_views/landing_social_meida.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingPageBottomSection extends StatelessWidget {
  const LandingPageBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          color: bottomColor,
          child: Padding(
            padding: EdgeInsets.only(left: si.isMobile ? 20 : 130),
            child: mainColumn(context),
          ),
        );
      },
    );
  }

  Column mainColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        mainRow(context),
        const SizedBox(height: 30),
        bottomSectionWidget(),
      ],
    );
  }

  Widget contactUsWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(myTuneLocationStr.tr,
              fontName: FontName.bold, color: atomCryan, fontSize: 18),
          const SizedBox(height: 4),
          customText(myTuneLocationValueStr.tr, fontSize: 14),
        ],
      ),
    );
  }

  Widget mainRow(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LandingCompanyView(),
                  const SizedBox(height: 20),
                  contactUsWidget(),
                  const SizedBox(height: 20),
                  const LandingSocialMedia(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LandingCompanyView(),
                      const SizedBox(height: 20),
                      const LandingSocialMedia(),
                    ],
                  ),
                  contactUsWidget(),
                ],
              );
      },
    );
  }

  Widget bottomSectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 0.5,
          color: white,
        ),
        copyRight(),
      ],
    );
  }

  Widget customText(
    String title, {
    Function()? onTap,
    Color color = white,
    FontName fontName = FontName.light,
    double fontSize = 14,
  }) {
    return CustomTextButton(
      title: title,
      textColor: color,
      fontName: fontName,
      fontSize: fontSize,
      onTap: onTap,
    );
  }

  Widget copyRight() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child:
          customText(copyRightStr.tr, fontSize: 12, fontName: FontName.light),
    );
  }
}
