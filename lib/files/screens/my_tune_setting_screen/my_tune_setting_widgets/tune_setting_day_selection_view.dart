import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget tuneSettingDaySelectionView() {
  TuneSettingController cont = Get.find();

  return ResponsiveBuilder(builder: (context, si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        const CustomText(
          title: repeatStr,
          fontName: FontName.ztregular,
          fontSize: 14,
        ),
        const SizedBox(height: 8),
        Obx(() {
          bool isLessWid = MediaQuery.of(context).size.width < 700;
          return SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                _dayButton(isLessWid ? sStr : sunStr,
                    cont.daysList[0].isSelected!.value, 0, cont),
                _dayButton(isLessWid ? mStr : monStr,
                    cont.daysList[1].isSelected!.value, 1, cont),
                _dayButton(isLessWid ? tStr : tueStr,
                    cont.daysList[2].isSelected!.value, 2, cont),
                _dayButton(isLessWid ? wStr : wedStr,
                    cont.daysList[3].isSelected!.value, 3, cont),
                _dayButton(isLessWid ? tStr : thusStr,
                    cont.daysList[4].isSelected!.value, 4, cont),
                _dayButton(isLessWid ? fStr : friStr,
                    cont.daysList[5].isSelected!.value, 5, cont),
                _dayButton(isLessWid ? saStr : satStr,
                    cont.daysList[6].isSelected!.value, 6, cont),
              ],
            ),
          );
        })
      ],
    );
  });
}

Widget _dayButton(
    String title, bool isSelected, int index, TuneSettingController cont) {
  selectedDaysUpdate(cont);

  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: CustomButton(
      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
      color: isSelected ? blue : white,
      textColor: isSelected ? white : blue,
      borderColor: isSelected ? blue : blueLight,
      height: 35,
      fontName: isSelected ? FontName.ztregular : FontName.abook,
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
