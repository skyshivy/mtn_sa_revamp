import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/string_json_file/help_file.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HelpScreen extends StatelessWidget {
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
                  verticalHeight(si),
                  customHeader(sectionOneHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(sectionOneHeaderSubTitleFile, si,
                      size: si.isMobile ? 15 : 16),
                  verticalHeight(si),
                  infoWidget(sectionOneHeaderInfoFile, si),
                  verticalHeight(si),
                  customHeader(sectionTwoHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(sectionTwoHeaderInfoFile, si),
                  verticalHeight(si),
                  customHeader(sectionThreeHeaderFile, si),
                  verticalHeight(si),
                  infoWidget(sectionThreeHeaderInfoFile, si),
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
        printCustom("Clicked ${link.url}!");
      },
      text: text,
      style: TextStyle(
          fontFamily: FontName.medium.name,
          fontSize: size ?? (si.isMobile ? 12 : 14)),
    );
  }
}
