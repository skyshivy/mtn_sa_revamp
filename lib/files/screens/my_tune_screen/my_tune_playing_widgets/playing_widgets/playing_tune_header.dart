import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget myTuneplayingHeaderView() {
  return ResponsiveBuilder(
    builder: (context, si) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _leftWidget(si),
              Row(
                children: [
                  _suffleText(si),
                  _toggleButton(),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _leftWidget(SizingInformation si) {
  return CustomText(
    title: currentlyPlayingToMyCallerStr.tr,
    fontName: FontName.light,
    fontSize: si.isMobile ? 18 : 30,
  );
}

Widget _suffleText(SizingInformation si) {
  return CustomText(
    title: shuffleStr.tr,
    fontName: FontName.light,
    fontSize: si.isMobile ? 14 : 18,
    textColor: subTitleColor,
  );
}

Widget _toggleButton() {
  MyTuneController controller = Get.find();
  return Obx(
    () {
      return controller.isChangeSuffle.value
          ? SizedBox(
              width: 60, child: Center(child: loadingIndicator(radius: 14)))
          : Switch.adaptive(
              value: controller.isSuffle.value,
              activeColor: atomCryan,
              activeTrackColor: blue,
              onChanged: (value) {
                Get.dialog(CustomConfirmAlertView(
                  fontName: FontName.medium,
                  message: controller.isSuffle.value
                      ? tuneSuffleOnMessageStr.tr
                      : tuneSuffleOffMessageStr.tr,
                  cancelTitle: cancelStr.tr,
                  okTitle: confirmStr.tr,
                  onOk: () {
                    controller.suffleTune();
                    printCustom("Relaod data");
                  },
                ));

                //
                //controller.isSuffle.value = !controller.isSuffle.value;
                printCustom("On change swith");
              },
            );
    },
  );
}
