import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class LandingCompanyView extends StatefulWidget {
  const LandingCompanyView({super.key});

  @override
  State<StatefulWidget> createState() => _LandingCompanyViewState();
}

class _LandingCompanyViewState extends State<LandingCompanyView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return companyList();
  }

  Widget companyList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(companyStr,
            fontName: FontName.aheavy, color: lightGreen, fontSize: 18),
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
    FontName fontName = FontName.abook,
    double fontSize = 14,
  }) {
    return CustomTextButton(
      title: title,
      textColor: color,
      fontName: fontName,
      fontSize: fontSize,
      titlePadding: const EdgeInsets.only(top: 4, bottom: 4),
      onTap: onTap,
    );
  }

  void contactusTapped() async {
    print("Contact us tapped  url =$contactUsUrl");
    await customWebLauncher(contactUsUrl);
  }

  void helpTapped() async {
    print("helpTapped tapped url = $helpUrl");
    await customWebLauncher(helpUrl);
  }

  void privacyTapped() async {
    print("privacyTapped tapped url =$privacyUrl");
    await customWebLauncher(privacyUrl);
  }

  void termsTapped() async {
    print("termsTapped tapped url =$termsUrl");
    await customWebLauncher(termsUrl);
  }
}
