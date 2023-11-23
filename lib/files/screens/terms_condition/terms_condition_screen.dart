import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/string_json_file/terms_condition_file.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TermsConditionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 20 : 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: si.isMobile ? 20 : 30),
                  customHeader(termsAndCondHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(termsAndConditionSubTitleFile, si,
                      size: si.isMobile ? 15 : 16),
                  verticalHeight(si),
                  infoWidget(termsAndConditionInfoFile, si),
                  verticalHeight(si),
                  customHeader(registrationHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(registrationInfoFile, si),
                  verticalHeight(si),
                  customHeader(privacyFile, si),
                  verticalHeight(si),
                  infoWidget(privacyInfoFile, si),
                  verticalHeight(si),
                  customHeader(accountFile, si),
                  verticalHeight(si),
                  infoWidget(accountInfo, si),
                  verticalHeight(si),
                  customHeader(copyRightFile, si),
                  verticalHeight(si),
                  infoWidget(copyRightInfoFile, si),
                  verticalHeight(si),
                  customHeader(trademarksFile, si),
                  verticalHeight(si),
                  infoWidget(trademarksInfoFile, si),
                  verticalHeight(si),
                  customHeader(productDescriptionFile, si),
                  verticalHeight(si),
                  infoWidget(productDescriptionInfoFile, si),
                  verticalHeight(si),
                  customHeader(paymentSetlementFile, si),
                  verticalHeight(si),
                  infoWidget(paymentSetlementInfoFile, si),
                  verticalHeight(si),
                  customHeader(accountFile, si),
                  verticalHeight(si),
                  infoWidget(accountInfo, si),
                  verticalHeight(si),
                  customHeader(termsAndCondHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(termsAndConditionInfoFile, si),
                  verticalHeight(si),
                  customHeader(sitePolicyFile, si),
                  verticalHeight(si),
                  infoWidget(sitePolicyInfoFile, si),
                  verticalHeight(si),
                  customHeader(disclaimerFile, si),
                  verticalHeight(si),
                  infoWidget(disclaimerInfoFile, si),
                  verticalHeight(si),
                  customHeader(applicableFile, si),
                  verticalHeight(si),
                  infoWidget(applicableInfoFile, si),
                  verticalHeight(si),
                  verticalHeight(si),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget verticalHeight(SizingInformation si) {
    return SizedBox(height: si.isMobile ? 15 : 30);
  }

  Widget customHeader(String text, SizingInformation si) {
    return CustomText(
      title: text,
      fontName: FontName.extraBold,
      fontSize: si.isMobile ? 18 : 25,
    );
  }

  Widget infoWidget(String text, SizingInformation si, {double? size}) {
    return Linkify(
      linkStyle: TextStyle(
          //color: blue,
          fontFamily: FontName.bold.name,
          fontSize: size ?? (si.isMobile ? 12 : 14)),
      options: const LinkifyOptions(humanize: false),
      onOpen: (link) {
        customWebLauncher(link.url);
        print("Clicked ${link.url}!");
      },
      text: text,
      style: TextStyle(
          fontFamily: FontName.medium.name,
          fontSize: size ?? (si.isMobile ? 12 : 14)),
    );
  }
}
