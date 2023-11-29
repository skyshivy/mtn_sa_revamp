import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget playingTuneRepeatDays(ListToneApk item) {
  printCustom("Repeat day s== ${item.toneDetails?.first.weeklyDays}");
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _repeat(),
      const SizedBox(height: 3),
      _dayListView(item),
    ],
  );
}

Widget _repeat() {
  return CustomText(
    title: repeatStr.tr,
    fontName: FontName.light,
    fontSize: 13,
    textColor: subTitleColor,
  );
}

Widget _dayListView(ListToneApk item) {
  return SizedBox(
    height: 30,
    child: ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        _dayButton(sStr.tr, item, 1),
        _dayButton(mStr.tr, item, 2),
        _dayButton(tuStr.tr, item, 3),
        _dayButton(wStr.tr, item, 4),
        _dayButton(tStr.tr, item, 5),
        _dayButton(fStr.tr, item, 6),
        _dayButton(saStr.tr, item, 7),
      ],
    ),
  );
}

Widget _dayButton(String title, ListToneApk item, int index) {
  var str = item.toneDetails?.first.weeklyDays ?? "";
  var arr = str.split(",");
  bool isSelected = arr.contains("$index");
  //printCustom("Is selected is $isSelected");
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: CustomButton(
      width: 30,
      color: isSelected ? atomCryan : grey,
      height: 30,
      title: title,
    ),
  );
}
