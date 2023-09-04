import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class LandingInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPhone(context) ? 250 : 500,
      color: blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isPhone(context)
              ? const SizedBox(
                  width: 20,
                )
              : Flexible(child: leftImageWidget()),
          Flexible(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              expressWidget(),
              infoDot(homeInfo1),
              infoDot(homeInfo2),
              infoDot(homeInfo3),
              infoDot(homeInfo4),
              infoDot(homeInfo5),
              infoDot(homeInfo6),
            ],
          )),
        ],
      ),
    );
  }

  CustomText expressWidget() {
    return CustomText(
      title: express,
      fontName: FontName.bold,
      fontSize: fontSize(20, 50),
    );
  }

  Widget leftImageWidget() {
    return Image.asset(
      tuneMoodImg,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget infoDot(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dotWidget(),
          const SizedBox(width: 4),
          Expanded(child: textWidget(title)),
        ],
      ),
    );
  }

  CustomText textWidget(String title) {
    return CustomText(
      title: title,
      fontName: FontName.regular,
      fontSize: fontSize(14, 24),
    );
  }

  Padding dotWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        height: 6,
        width: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black,
        ),
      ),
    );
  }
}
