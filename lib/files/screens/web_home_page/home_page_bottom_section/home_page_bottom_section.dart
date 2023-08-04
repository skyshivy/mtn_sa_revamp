import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/sub_views/landing_company_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/sub_views/landing_social_meida.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class LandingPageBottomSection extends StatelessWidget {
  const LandingPageBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 130),
        child: mainColumn(),
      ),
    );
  }

  Column mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        mainRow(),
        const SizedBox(height: 30),
        bottomSectionWidget(),
      ],
    );
  }

  Row mainRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LandingCompanyView(),
        const SizedBox(width: 100),
        const LandingSocialMedia(),
      ],
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
      child: customText(copyRightStr, fontSize: 12, fontName: FontName.light),
    );
  }
}
