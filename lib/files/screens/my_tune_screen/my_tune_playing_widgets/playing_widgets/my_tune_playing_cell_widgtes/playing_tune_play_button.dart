import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget playingTunePlayButton(TuneInfo info, int index) {
  PlayerController pCont = Get.find();
  return Obx(
    () {
      return CustomButton(
        height: 40,
        width: 40,
        color: darkGreen,
        leftWidget: _playAndPauseButtonIcon(pCont, index),
        // Icon(
        //   Icons.play_arrow,
        //   color: white,
        // ),
        onTap: () {
          pCont.playUrl(info.toneIdStreamingUrl ?? '', index);
        },
      );
    },
  );
}
