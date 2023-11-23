import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/string_json_file/privacy_policy.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, si) {
      return ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 20 : 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: si.isMobile ? 15 : 25),
                CustomText(
                  title: privacyHeaderString,
                  fontName: FontName.extraBold,
                  fontSize: si.isMobile ? 18 : 25,
                ),
                SizedBox(height: si.isMobile ? 8 : 20),
                CustomText(
                  title: privacySubTitle,
                  fontName: FontName.bold,
                  fontSize: si.isMobile ? 12 : 14,
                ),
                SizedBox(height: si.isMobile ? 8 : 20),
                Linkify(
                  options: const LinkifyOptions(humanize: false),
                  onOpen: (link) {
                    customWebLauncher(link.url);
                    print("Clicked ${link.url}!");
                  },
                  text: pricacyInfo,
                  style: TextStyle(
                      fontFamily: FontName.medium.name,
                      fontSize: si.isMobile ? 12 : 14),
                ),
                SizedBox(height: si.isMobile ? 20 : 80),
              ],
            ),
          )
        ],
      );
    });
  }
}
