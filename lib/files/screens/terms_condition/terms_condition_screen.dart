import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
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
                  customHeader(
                      StoreManager().isEnglish
                          ? termsAndCondHeaderFile
                          : termsAndCondHeaderFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? termsAndConditionSubTitleFile
                          : termsAndConditionSubTitleFileBr,
                      si,
                      size: si.isMobile ? 15 : 16),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? termsAndConditionInfoFile
                          : termsAndConditionInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? registrationHeaderFile
                          : registrationHeaderFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? registrationInfoFile
                          : registrationInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish ? privacyFile : privacyFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? privacyInfoFile
                          : privacyInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish ? accountFile : accountFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish ? accountInfo : accountInfoBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? copyRightFile
                          : copyRightFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? copyRightInfoFile
                          : copyRightInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? trademarksFile
                          : trademarksFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? trademarksInfoFile
                          : trademarksInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? productDescriptionFile
                          : productDescriptionFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? productDescriptionInfoFile
                          : productDescriptionInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? paymentSetlementFile
                          : paymentSetlementFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? paymentSetlementInfoFile
                          : paymentSetlementInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish ? accountFile : accountFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish ? accountInfo : accountInfoBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? termsAndCondHeaderFile
                          : termsAndCondHeaderFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? termsAndConditionInfoFile
                          : termsAndConditionInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? sitePolicyFile
                          : sitePolicyFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? sitePolicyInfoFile
                          : sitePolicyInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? disclaimerFile
                          : disclaimerFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? disclaimerInfoFile
                          : disclaimerInfoFileBr,
                      si),
                  verticalHeight(si),
                  customHeader(
                      StoreManager().isEnglish
                          ? applicableFile
                          : applicableFileBr,
                      si),
                  verticalHeight(si),
                  infoWidget(
                      StoreManager().isEnglish
                          ? applicableInfoFile
                          : applicableInfoFileBr,
                      si),
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
