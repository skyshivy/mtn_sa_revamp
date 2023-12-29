import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/set_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettunePopup extends StatefulWidget {
  final TuneInfo? info;
  SettunePopup({super.key, this.info});
  @override
  State<StatefulWidget> createState() => _SettunePopupState();
}

class _SettunePopupState extends State<SettunePopup> {
  late SetTuneController con;
  @override
  void initState() {
    con = Get.put(SetTuneController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SetTuneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: white,
            ),
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topHeaderView(context, si),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: tuneImage(),
                )),
                pickerView(),
                veryfyButton(context, si),
                infoMessage(si),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topHeaderView(BuildContext context, SizingInformation si) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          topHeaderTitleButton(si),
          closeButton(context),
        ],
      ),
    );
  }

  Widget topHeaderTitleButton(SizingInformation si) {
    return CustomText(
      title: (statusTuneStr.tr),
      fontSize: si.isMobile ? 18 : 22,
      fontName: FontName.aheavy,
    );
  }

  Widget closeButton(BuildContext context) {
    return CustomButton(
      leftWidget: const Icon(Icons.close),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget tuneImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CustomImage(
        height: 180,
        url: widget.info?.toneIdpreviewImageUrl ??
            widget.info?.previewImageUrl ??
            '',
      ),
    );
  }

  Widget pickerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [dayPicker(), hourPicker(), minutePicker()],
    );
  }

  Widget dayPicker() {
    return Obx(() {
      return genericPicket(dayStr, 7, con.selectedDay.value, (p0) {
        con.selectedDay.value = p0;
      });
    });
  }

  Widget hourPicker() {
    return Obx(() {
      return genericPicket(hourStr, 23, con.selectedHour.value, (p0) {
        con.selectedHour.value = p0;
      });
    });
  }

  Widget minutePicker() {
    return Obx(() {
      return genericPicket(minuteStr, 59, con.selectedMinute.value, (p0) {
        con.selectedMinute.value = p0;
      });
    });
  }

  Widget genericPicket(
      String title, int maxNum, int value, Function(int) onChange) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18),
            CustomText(
              title: title,
              fontSize: si.isMobile ? 14 : 16,
              fontName: FontName.aheavy,
            ),
            NumberPicker(
              haptics: true,
              zeroPad: true,
              textStyle: TextStyle(
                  color: lightGreen,
                  fontSize: si.isMobile ? 12 : 14,
                  fontWeight: FontWeight.bold),
              selectedTextStyle: TextStyle(
                  color: red,
                  fontSize: si.isMobile ? 14 : 18,
                  fontWeight: FontWeight.bold),
              itemHeight: 30,
              minValue: 0,
              maxValue: maxNum,
              value: value,
              onChanged: (value) {
                onChange(value);
                print("selected day");
              },
            ),
            const SizedBox(height: 18),
          ],
        );
      },
    );
  }

  Widget veryfyButton(BuildContext context, SizingInformation si) {
    return CustomButton(
      width: 260,
      height: 35,
      color: red,
      textColor: white,
      title: confirmStr,
      fontName: si.isMobile ? FontName.abook : FontName.aheavy,
      onTap: () async {
        print("Set tune tapped");
        //}
        print("Tapped ${StoreManager().isLoggedIn}");
      },
    );
  }

  Widget infoMessage(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        title: setTuneMessageStr.tr,
        fontSize: si.isMobile ? 12 : 14,
        alignment: TextAlign.center,
      ),
    );
  }
}
