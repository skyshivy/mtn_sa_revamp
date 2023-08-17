import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingDedicatedMsisdnView() {
  TuneSettingController tuneSettingCont = Get.find();
  return SizedBox(
    height: 50,
    width: 300,
    child: Obx(
      () {
        return CustomMsisdnTextField(
          countryCodeColor: black,
          hintText: enterNuberStr,
          borderColor: borderColor,
          cornerRadius: 4,
          onChanged: (p0) {
            tuneSettingCont.updateMsisdn(p0);
          },
          bgColor: white,
          text: tuneSettingCont.msisdn.value,
        );
      },
    ),
  );
}
