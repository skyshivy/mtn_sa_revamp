import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget buyButton(SizingInformation si, TuneInfo info) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: blue,
    ),
    height: 40,
    child: InkWell(
      onTap: () {
        printCustom("Buy button");
        BuyTuneScreen().show(info);
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              buyImg,
              height: si.isMobile ? 15 : 18,
              width: si.isMobile ? 15 : 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: CustomText(
                  title: buyStr.tr,
                  fontSize: si.isMobile ? 13 : 15,
                  textColor: white,
                  fontName: si.isMobile ? FontName.medium : FontName.bold),
            )
          ],
        ),
      ),
    ),
  );
}
