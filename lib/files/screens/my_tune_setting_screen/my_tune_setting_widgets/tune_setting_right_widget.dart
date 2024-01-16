import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
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
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingRightWidgte() {
  TuneSettingController con = Get.find();
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: grey,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        crbtRrbtButtonContainer(),
        callerTypeWidget(con),
        Obx(() {
          return Visibility(
              visible: con.isCrbt.value, child: bottomSectionWidget(con));
        })
      ],
    ),
  );
}

Widget bottomSectionWidget(TuneSettingController con) {
  return Obx(() {
    return Visibility(
      visible: !(con.callerType.value == 2),
      child: Row(
        children: [
          _bottomWidget(),
        ],
      ),
    );
  });
}

Widget callerTypeWidget(TuneSettingController con) {
  return Obx(() {
    return con.isCrbt.value
        ? _topWidgetContaner()
        : _combinedWidget(
            addToShuffleStr); //Visibility(visible: con.isCrbt.value, child: _topWidgetContaner());
  });
}

Widget _combinedWidget(String title) {
  TuneSettingController cont = Get.find();
  cont.updateToWhom(ToWhomAction.addToSuffle);
  return Padding(
    padding: const EdgeInsets.only(left: 20, bottom: 50, top: 20),
    child: Row(
      children: [
        _radioButton(true),
        const SizedBox(width: 2),
        _titleButton(true, title),
      ],
    ),
  );
}

Widget _titleButton(bool isSelected, String title) {
  return CustomText(
    title: title,
    fontName: FontName.medium,
    fontSize: 14,
    textColor: black,
  );
}

Widget _radioButton(bool isSelected) {
  return Image.asset(
    radioButtonSelectedImg,
    width: 18,
  );
}

Widget crbtRrbtButtonContainer() {
  TuneSettingController con = Get.find();
  return Container(
      color: whiteTrans,
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: CustomButton(
                radius: 0,
                color: con.isCrbt.value ? blue : atomCryan,
                textColor: con.isCrbt.value ? white : black,
                //width: 80,
                title: crbtStr.tr,
                fontName: FontName.bold,
                onTap: () {
                  con.callerType.value = 0;
                  con.isCrbt.value = true;
                },
              ),
            ),
            const SizedBox(width: 1),
            Expanded(
              child: CustomButton(
                color: con.isCrbt.value ? atomCryan : blue,
                radius: 0,
                textColor: con.isCrbt.value ? black : white,
                //width: 80,
                title: rrbtStr.tr,
                fontName: FontName.bold,
                onTap: () {
                  con.callerType.value = 0;
                  con.isCrbt.value = false;
                },
              ),
            ),
          ],
        );
      }));
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
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: CustomText(
      title: whenYouWantToPlayItStr.tr,
      fontName: FontName.medium,
      fontSize: 16,
    ),
  );
}

Widget _addNumberText() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2),
    child: CustomText(
      title: addNuberStr.tr,
      fontName: FontName.medium,
      fontSize: 16,
    ),
  );
}
