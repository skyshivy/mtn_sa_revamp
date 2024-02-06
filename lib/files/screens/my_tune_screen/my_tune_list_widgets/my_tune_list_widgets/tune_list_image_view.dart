import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_more_button.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget tuneListImageView(ListToneApk1 info, int index) {
  return Stack(
    alignment: Alignment.bottomLeft,
    children: [
      Stack(
        alignment: Alignment.topCenter,
        children: [
          customImage(
              url: info.toneDetails?.first.toneIdpreviewImageUrl,
              gradient: customGredient(blackGredient, blackGredient)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tuneListLikeButton(info),
                _tuneListMoreButton(
                    index, info.toneDetails?.first ?? TuneInfo())
              ],
            ),
          )
        ],
      ),
      inActiveStatus(info),
    ],
  );
}

Widget inActiveStatus(ListToneApk1 info) {
  bool isActive = (info.toneDetails?.first.status == "A");
  return ResponsiveBuilder(
    builder: (context, si) {
      return Visibility(
        visible: !isActive,
        child: Padding(
          padding: EdgeInsets.only(bottom: si.isMobile ? 20 : 40),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    ribbonImg,
                    fit: BoxFit.fill,
                    color: grey,
                    height: si.isMobile ? 40 : 50,
                    width: si.isMobile ? 120 : 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomText(
                      title: inActiveStr.tr,
                      fontName: FontName.medium,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _tuneListLikeButton(ListToneApk1 info) {
  return const SizedBox();
  // CustomButton(
  //   color: whiteTrans,
  //   height: 30,
  //   title: "",
  //   fontName: FontName.medium,
  //   titlePadding: const EdgeInsets.only(left: 4, right: 12),
  //   leftWidget: Padding(
  //     padding: const EdgeInsets.only(left: 12),
  //     child: Image.asset(
  //       likeImg,
  //       height: 15,
  //       width: 15,
  //     ),
  //   ),
  // );
}

Widget _tuneListMoreButton(int index, TuneInfo info) {
  return TuneListMoreButton(
    index: index,
    info: info,
  );
  // CustomButton(
  //   color: whiteTrans,
  //   height: 30,
  //   width: 30,
  //   leftWidget: const Icon(
  //     Icons.more_horiz,
  //     color: grey,
  //   ),
  //   onTap: () {
  //     printCustom("_tuneListMoreButton");
  //   },
  // );
}
