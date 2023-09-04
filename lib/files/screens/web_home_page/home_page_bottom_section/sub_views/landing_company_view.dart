import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class LandingCompanyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return companyList();
  }

  Widget companyList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(companyStr,
            fontName: FontName.bold, color: blue, fontSize: 18),
        customText(contactusStr, onTap: contactusTapped),
        customText(helpStr, onTap: helpTapped),
        customText(privacyStr, onTap: privacyTapped),
        customText(termsStr, onTap: termsTapped),
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

  void contactusTapped() {
    print("Contact us tapped");
  }

  void helpTapped() {
    print("helpTapped tapped");
  }

  void privacyTapped() {
    print("privacyTapped tapped");
  }

  void termsTapped() {
    print("termsTapped tapped");
  }
}
