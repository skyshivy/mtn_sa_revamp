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
        const SizedBox(height: 4),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              mediaButton(facebookImg, () {
                customWebLauncher(facebook_url);
              }),
              const SizedBox(width: 12),
              mediaButton(instagramImg, () {
                customWebLauncher(instagram_url);
              }),
              const SizedBox(width: 12),
              mediaButton(twitterImg, () {
                customWebLauncher(twitter_url);
              }),
              const SizedBox(width: 12),
              mediaButton(linkedInImg, () {
                customWebLauncher(linkedin_url);
              }),
              const SizedBox(width: 12),
              mediaButton(youtubeImg, () {
                customWebLauncher(youtube_url);
              }),
              const SizedBox(width: 12),
              mediaButton(messangerImg, () {
                customWebLauncher(messanger_url);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget titleWidget() {
    return CustomText(
      title: fallowUsStr,
      fontName: FontName.bold,
      fontSize: 18,
      textColor: atomCryan,
    );
  }

  Widget mediaButton(String name, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: CustomButton(
        color: white,
        height: 40,
        width: 40,
        radius: 20,
        leftWidget: Center(
          child: Image.asset(
            name,
            height: 25,
            width: 25,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
