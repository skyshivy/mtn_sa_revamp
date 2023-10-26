import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingRepeatView() {
  TuneSettingController con = Get.find();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20),
      const CustomText(
        title: repeatStr,
        fontName: FontName.ztregular,
        fontSize: 14,
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          _noneButton(con),
          const SizedBox(width: 8),
          _monthlyButton(con),
          const SizedBox(width: 8),
          _yearlyButton(con),
        ],
      )
    ],
  );
}

Widget _noneButton(TuneSettingController con) {
  return Obx(() {
    return CustomButton(
      height: 35,
      fontName: FontName.ztregular,
      textColor: (con.repeatYear.value == 0) ? white : black,
      title: noneStr,
      borderColor: (con.repeatYear.value == 0) ? null : lightGreen,
      color: (con.repeatYear.value == 0) ? darkGreen : white,
      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () {
        con.updateRepeatYear(0);
      },
    );
  });
}

Widget _monthlyButton(TuneSettingController con) {
  return Obx(() {
    return CustomButton(
      height: 35,
      fontName: FontName.ztregular,
      title: monthlyStr,
      textColor: (con.repeatYear.value == 1) ? white : black,
      borderColor: (con.repeatYear.value == 1) ? null : lightGreen,
      color: (con.repeatYear.value == 1) ? darkGreen : white,
      titlePadding: EdgeInsets.symmetric(horizontal: 16),
      onTap: () {
        con.updateRepeatYear(1);
      },
    );
  });
}

Widget _yearlyButton(TuneSettingController con) {
  return Obx(() {
    return CustomButton(
      height: 35,
      fontName: FontName.ztregular,
      title: yearlyStr,
      textColor: (con.repeatYear.value == 2) ? white : black,
      borderColor: (con.repeatYear.value == 2) ? null : lightGreen,
      color: (con.repeatYear.value == 2) ? darkGreen : white,
      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () {
        con.updateRepeatYear(2);
      },
    );
  });
}
