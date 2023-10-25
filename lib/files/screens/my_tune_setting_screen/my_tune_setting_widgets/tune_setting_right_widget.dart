import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_day_selection_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_dedicated_msisdn_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_radio_btn_callers_type.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_repeat.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_time_type_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_time_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_settng_time_date_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingRightWidgte() {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: grey,
    ),
    child: Column(
      children: [
        _topWidgetContaner(),
        Row(
          children: [
            _bottomWidget(),
          ],
        ),
      ],
    ),
  );
}

Widget _topWidgetContaner() {
  return Container(
    color: greyLight,
    child: tuneSettingRadioButtonCallersType(),
  );
}

Widget _bottomWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _dedicatedUserTextField(),
        _whenWantToPlayText(),
        const SizedBox(height: 2),
        const TuneSettingTimeTypeButton(),
        _timeView(),
        _dateView(),
        _selectDayView(),
        _repeatYear(),
      ],
    ),
  );
}

Widget _selectDayView() {
  TuneSettingController con = Get.find();
  return Obx(() {
    return con.isTimeAndDate.value
        ? const SizedBox()
        : tuneSettingDaySelectionView();
  });
}

Widget _timeView() {
  TuneSettingController con = Get.find();
  return Obx(() {
    return con.isTime.value ? TuneSettingTimeView() : const SizedBox();
  });
}

Widget _dateView() {
  TuneSettingController con = Get.find();
  return Obx(() {
    return con.isTimeAndDate.value
        ? TuneSettingTimeDateView()
        : const SizedBox();
  });
}

Widget _repeatYear() {
  TuneSettingController con = Get.find();
  return Obx(() {
    return con.isTimeAndDate.value ? tuneSettingRepeatView() : const SizedBox();
  });
}

Widget _dedicatedUserTextField() {
  TuneSettingController tuneSettingCont = Get.find();
  return Obx(() {
    return (tuneSettingCont.callerType.value == 1)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _addNumberText(),
              const SizedBox(height: 2),
              tuneSettingDedicatedMsisdnView(),
              const SizedBox(height: 12),
            ],
          )
        : const SizedBox();
  });
}

Widget _whenWantToPlayText() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: CustomText(
      title: whenYouWantToPlayItStr,
      fontName: FontName.ztregular,
      fontSize: 16,
    ),
  );
}

Widget _addNumberText() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: CustomText(
      title: addNuberStr,
      fontName: FontName.ztregular,
      fontSize: 16,
    ),
  );
}
