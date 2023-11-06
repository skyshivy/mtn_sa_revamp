import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profileUserName(SizingInformation si) {
  ProfileController controller = Get.find();
  return SizedBox(
    width: si.isMobile ? null : 280,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          title: userNameStr,
          fontName: FontName.medium,
          fontSize: 14,
          textColor: subTitleColor,
        ),
        const SizedBox(height: 6),
        CustomTextField(
          fontName: FontName.medium,
          fontSize: 18,
          editEnable: controller.editEnable.value,
          text: controller.profileDetails?.userName ?? '',
          hintText: userNameStr,
          onChanged: (p0) {
            controller.updateUserName(p0);
          },
        ),
      ],
    ),
  );
}
