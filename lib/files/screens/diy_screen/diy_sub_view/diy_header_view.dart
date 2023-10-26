import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

import 'package:responsive_builder/responsive_builder.dart';

class DIYHeaderView extends StatelessWidget {
  const DIYHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Stack(
              children: [
                headerBackGroundView(sizeInfo),
                Positioned(
                    right: sizeInfo.isMobile ? -70 : -100,
                    child: ovalWidget(sizeInfo)),
              ],
            ),
            infoText(sizeInfo),
          ],
        );
      },
    );
  }

  Widget infoText(SizingInformation sizeInfo) {
    return Row(
      children: [
        SizedBox(
          width: sizeInfo.isMobile ? 20 : 50,
        ),
        Expanded(
          child: CustomText(
            alignment: TextAlign.left,
            title: shareYourOwnSongStr,
            fontName: FontName.ztbold,
            fontSize: sizeInfo.isMobile ? 16 : 28,
          ),
        ),
        Container(
          color: Colors.transparent,
          height: 20,
          width: sizeInfo.isMobile ? 140 : 320,
        )
      ],
    );
  }

  Widget headerBackGroundView(SizingInformation sizeInfo) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      height: sizeInfo.isMobile ? 150 : 250,
      width: double.infinity,
      child: Image.asset(
        diyBgImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget ovalWidget(SizingInformation sizeInfo) {
    double height = sizeInfo.isMobile ? 100 : 200;
    double width = sizeInfo.isMobile ? 200 : 400;
    return Align(
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
          gradient: customGredient(),
          color: darkGreen,
          borderRadius: BorderRadius.all(
            Radius.elliptical(width, height),
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: ovarText(sizeInfo),
        ),
      ),
    );
  }

  Widget ovarText(SizingInformation sizeInfo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeInfo.isMobile ? 20 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: doItYourStr,
            textColor: Colors.white,
            fontName: FontName.ztbold,
            fontSize: sizeInfo.isMobile ? 14 : 28,
          ),
          CustomText(
            title: createYourOwnTuneStr,
            textColor: Colors.white,
            fontSize: sizeInfo.isMobile ? 10 : 19,
          )
        ],
      ),
    );
  }
}
