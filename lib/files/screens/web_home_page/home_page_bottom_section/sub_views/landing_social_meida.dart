import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_web_launcher.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class LandingSocialMedia extends StatelessWidget {
  const LandingSocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        Row(
          children: [
            mediaButton(facebookImg, () {
              customWebLauncher(facebook_url);
            }),
            mediaButton(instagramImg, () {
              customWebLauncher(instagram_url);
            }),
            mediaButton(twitterImg, () {
              customWebLauncher(twitter_url);
            }),
            mediaButton(linkedInImg, () {
              customWebLauncher(linkedin_url);
            }),
          ],
        ),
      ],
    );
  }

  CustomText titleWidget() {
    return const CustomText(
      title: fallowUsStr,
      fontName: FontName.bold,
      fontSize: 18,
      textColor: atomCryan,
    );
  }

  Widget mediaButton(String name, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: CustomButton(
        color: white,
        height: 40,
        width: 40,
        radius: 20,
        leftWidget: Image.asset(name),
        onTap: onTap,
      ),
    );
  }
}
