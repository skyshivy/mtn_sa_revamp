import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
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
            fontName: FontName.bold, color: atomCryan, fontSize: 18),
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
    Others? others = StoreManager().appSetting.responseMap?.settings?.others;
    String url = '';
    if (StoreManager().isEnglish) {
      url = others?.aboutAppurlEnglish?.attribute ?? '';
    } else {
      url = others?.aboutAppurlEnglish?.attribute ?? '';
    }
    customWebLauncher(url);
  }

  void helpTapped() {
    print("helpTapped tapped");
    Others? others = StoreManager().appSetting.responseMap?.settings?.others;
    String url = '';
    if (StoreManager().isEnglish) {
      url = others?.helpEnglish?.attribute ?? '';
    } else {
      url = others?.helpBurmese?.attribute ?? '';
    }
    customWebLauncher(url);
  }

  void privacyTapped() {
    print("privacyTapped tapped");
    Others? others = StoreManager().appSetting.responseMap?.settings?.others;
    String url = '';
    if (StoreManager().isEnglish) {
      url = others?.pPolicyEnglish?.attribute ?? '';
    } else {
      url = others?.pPolicyBurmese?.attribute ?? '';
    }
    customWebLauncher(url);
  }

  void termsTapped() {
    Others? others = StoreManager().appSetting.responseMap?.settings?.others;
    String url = '';
    if (StoreManager().isEnglish) {
      url = others?.tndEnglish?.attribute ?? '';
    } else {
      url = others?.tndBurmese?.attribute ?? '';
    }
    print("Url is ===== $url");
    customWebLauncher(url);
    print("termsTapped tapped");
  }
}
