import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget myTuneplayingHeaderView() {
  return SizedBox(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _leftWidget(),
        Row(
          children: [
            _suffleText(),
            _toggleButton(),
          ],
        )
      ],
    ),
  );
}

Widget _leftWidget() {
  return const CustomText(
    title: currentlyPlayingToMyCallerStr,
    fontName: FontName.light,
    fontSize: 30,
  );
}

Widget _suffleText() {
  return const CustomText(
    title: shuffleStr,
    fontName: FontName.light,
    fontSize: 18,
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
              onChanged: (value) {
                controller.suffleTune();
                //controller.isSuffle.value = !controller.isSuffle.value;
                print("On change swith");
              },
            );
    },
  );
}
