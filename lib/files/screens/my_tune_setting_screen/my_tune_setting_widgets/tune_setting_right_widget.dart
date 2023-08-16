import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_day_selection_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_radio_btn_callers_type.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_time_type_button.dart';
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
        )
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
        _whenWantToPlayText(),
        const SizedBox(height: 8),
        const TuneSettingTimeTypeButton(),
        tuneSettingDaySelectionView(),
      ],
    ),
  );
}

Widget _whenWantToPlayText() {
  return const CustomText(
    title: whenYouWantToPlayItStr,
    fontName: FontName.bold,
    fontSize: 18,
  );
}
