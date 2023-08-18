import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingDaySelectionView() {
  TuneSettingController cont = Get.find();

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        const CustomText(
          title: repeatStr,
          fontName: FontName.medium,
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        Obx(() {
          return Row(
            children: [
              _dayButton(sunStr, cont.daysList[0].isSelected!.value, 0, cont),
              _dayButton(monStr, cont.daysList[1].isSelected!.value, 1, cont),
              _dayButton(tueStr, cont.daysList[2].isSelected!.value, 2, cont),
              _dayButton(wedStr, cont.daysList[3].isSelected!.value, 3, cont),
              _dayButton(thusStr, cont.daysList[4].isSelected!.value, 4, cont),
              _dayButton(friStr, cont.daysList[5].isSelected!.value, 5, cont),
              _dayButton(satStr, cont.daysList[6].isSelected!.value, 6, cont),
            ],
          );
        })
      ],
    ),
  );
}

Widget _dayButton(
    String title, bool isSelected, int index, TuneSettingController cont) {
  selectedDaysUpdate(cont);

  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: CustomButton(
      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
      color: isSelected ? yellow : white,
      borderColor: isSelected ? yellow : red,
      height: 35,
      fontName: isSelected ? FontName.medium : FontName.regular,
      title: title,
      onTap: () {
        cont.daysList[index].isSelected!.value =
            !(cont.daysList[index].isSelected!.value);
        selectedDaysUpdate(cont);
      },
    ),
  );
}

selectedDaysUpdate(TuneSettingController cont) {
  String selDays = '';
  for (int i = 0; i < cont.daysList.length; i++) {
    if (cont.daysList[i].isSelected!.value) {
      selDays.isEmpty ? (selDays += "${i + 1}") : (selDays += ",${i + 1}");
    }
  }
  cont.updateSelectedDay(selDays);
}
