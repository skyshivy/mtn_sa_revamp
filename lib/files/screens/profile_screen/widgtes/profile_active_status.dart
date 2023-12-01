import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profileActiveStatus() {
  ProfileController pCont = Get.find();
  return Obx(() {
    return Visibility(
      visible: pCont.crbtPackName.isNotEmpty,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // packNameStr +
              //       '\n' +
              CustomText(
                alignment: TextAlign.center,
                title: packNameStr.tr,
                textColor: subTitleColor,
                fontName: si.isMobile ? FontName.bold : FontName.medium,
                fontSize: si.isMobile ? 12 : 14,
              ),
              const SizedBox(height: 4),
              CustomText(
                alignment: TextAlign.center,
                title: (pCont.crbtPackName.value)
                    .replaceAll("CRBT_", " ")
                    .replaceAll("crbt_", " ")
                    .toUpperCase(),
                textColor: black,
                fontName: FontName.bold,
                fontSize: si.isMobile ? 12 : 14,
              ),
            ],
          );
        },
      ),
    );
  });
}
