import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class TuneSettingTimeTypeButton extends StatefulWidget {
  const TuneSettingTimeTypeButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return TuneSettingTimeTypeButtonState();
  }
}

class TuneSettingTimeTypeButtonState extends State<TuneSettingTimeTypeButton> {
  TuneSettingController con = Get.find();
  GlobalKey _key = GlobalKey();
  List<MenuModel> menuList = [
    MenuModel(fullDay24HourStr),
    MenuModel(selecteTimeStr),
    MenuModel(selectRepeatStr)
  ];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _key,
      onTap: () {
        print("tuneSettingTimeTypeButton tapped");

        Get.dialog(showPositionedPopup(_key, menuList, onTap: action));
      },
      child: Container(
        height: 55,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: white,
            border: Border.all(color: borderColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleWidget(),
                  _timeTypeTitleWidget(),
                ],
              ),
            ),
            dropIconWidget()
          ],
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return const CustomText(
      title: selectTimeTypeStr,
      fontName: FontName.light,
      fontSize: 12,
      textColor: subTitleColor,
    );
  }

  Widget _timeTypeTitleWidget() {
    return Obx(() {
      return CustomText(
        title: con.timeTypeBtm.value,
        textColor: red,
        fontName: FontName.medium,
        fontSize: 14,
      );
    });
  }

  Widget dropIconWidget() {
    return const Icon(Icons.arrow_drop_down);
  }

  void action(MenuModel model) {
    print("Model is name ${model.title}");
    if (model.title == fullDay24HourStr) {
      con.timeTypeBtm.value = fullDay24HourStr;
      con.updateTimeType(SelectTimeType.fullday);
    } else if (model.title == selecteTimeStr) {
      con.timeTypeBtm.value = selecteTimeStr;
      con.updateTimeType(SelectTimeType.time);
    } else if (model.title == selectRepeatStr) {
      con.timeTypeBtm.value = selectRepeatStr;
      con.updateTimeType(SelectTimeType.timeDate);
    }
  }
}
