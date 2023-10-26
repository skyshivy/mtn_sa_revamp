import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingConfirmButton() {
  TuneSettingController tuneController = Get.find();
  return CustomButton(
    width: 160,
    textColor: white,
    titlePadding: const EdgeInsets.symmetric(horizontal: 20),
    fontName: FontName.ztregular,
    color: darkGreen,
    title: confirmStr,
    onTap: () {
      tuneController.setTune();
      //print("Confirm button tapped");
    },
  );
}
