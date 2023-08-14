import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_tune_info.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';

Widget tuneSettingImage() {
  TuneSettingController con = Get.find();
  return Container(
    height: 200,
    width: 250,
    clipBehavior: Clip.hardEdge,
    decoration: containerDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CustomImage(
          url: con.tuneImage,
          gradient: customGredient(blackGredient, blackGredient),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: tuneSettingTuneInfo(),
        ),
      ],
    ),
  );
}

BoxDecoration containerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    color: white,
    boxShadow: const [
      BoxShadow(color: blackGredient, spreadRadius: 1, blurRadius: 4)
    ],
  );
}
