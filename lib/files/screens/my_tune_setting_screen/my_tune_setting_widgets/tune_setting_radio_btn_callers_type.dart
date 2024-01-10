import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget tuneSettingRadioButtonCallersType() {
  TuneSettingController cont = Get.find();
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(),
          const SizedBox(height: 6),
          Obx(() {
            return Row(
              children: [
                _combinedWidget(0, cont.callerType.value == 0, allCallerStr.tr),
                const SizedBox(width: 20),
                _combinedWidget(
                    1, cont.callerType.value == 1, specificCallerStr.tr),
                const SizedBox(width: 20),
                _combinedWidget(
                    2, cont.callerType.value == 2, addToShuffleStr.tr),
              ],
            );
          })
        ],
      ),
    ),
  );
}

Widget titleWidget() {
  return CustomText(
    title: whomYouWantToPlayItStr.tr,
    fontName: FontName.bold,
    fontSize: 18,
  );
}

Widget _combinedWidget(int index, bool isSelected, String title) {
  TuneSettingController cont = Get.find();
  return InkWell(
    onTap: () {
      cont.callerType.value = index;
      cont.updateToWhom(index == 0
              ? ToWhomAction.allCaller
              : (index == 1
                  ? ToWhomAction.specificCaller
                  : ToWhomAction.addToSuffle)
          // (index == 1
          //     ? ToWhomAction.specificCaller
          //     : ToWhomAction.callerGroup)
          );
      printCustom("tuneSettingRadioButtonCallersType tapped");
    },
    child: Row(
      children: [
        _radioButton(isSelected),
        const SizedBox(width: 2),
        _titleButton(isSelected, title),
      ],
    ),
  );
}

Widget _radioButton(bool isSelected) {
  return Image.asset(
    isSelected ? radioButtonSelectedImg : radioButtonUnSelectedImg,
    width: 18,
  );
  Icon(
    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
    color: isSelected ? atomCryan : subTitleColor,
    size: 18,
  ); //SizedBox(child: ,);
}

Widget _titleButton(bool isSelected, String title) {
  return CustomText(
    title: title,
    fontName: FontName.medium,
    fontSize: 14,
    textColor: isSelected ? black : subTitleColor,
  );
}
