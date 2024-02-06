import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profileMobileNumberWidget(SizingInformation si) {
  ProfileController profileController = Get.find();
  return SizedBox(
    width: si.isMobile ? null : 280,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: mobileNumberStr.tr,
          fontName: FontName.medium,
          fontSize: 14,
          textColor: subTitleColor,
        ),
        const SizedBox(height: 6),
        CustomTextField(
          fontName: FontName.medium,
          fontSize: 18,
          isBorder: false,
          bgColor: grey,
          editEnable: false,
          text: profileController.profileDetails?.msisdn ?? '',
          hintText: mobileNumberStr.tr,
        ),
      ],
    ),
  );
}
