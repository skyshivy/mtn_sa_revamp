import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';
import 'package:mtn_sa_revamp/flies/utility/string.dart';

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
            mediaButton(facebookImg, () => null),
            mediaButton(instagramImg, () => null),
            mediaButton(twitterImg, () => null),
            mediaButton(linkedInImg, () => null),
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
      textColor: yellow,
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
