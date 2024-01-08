import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget tuneListPlayButton(TuneInfo info, int index) {
  PlayerController pCont = Get.find();
  return Obx(
    () {
      return CustomButton(
          onTap: () {
            printCustom("tuneListPlayButton");
            pCont.playUrl(info, index);
          },
          height: 40,
          borderColor: atomCryan,
          titlePadding: const EdgeInsets.symmetric(horizontal: 4),
          //color: yellow,
          title: playStr.tr,
          fontName: FontName.medium,
          fontSize: 16,
          leftWidget: _playAndPauseButtonIcon(pCont, index)
          // const Icon(
          //   Icons.play_arrow,
          //   color: black,
          // ),
          );
    },
  );
}

Widget _playAndPauseButtonIcon(PlayerController pCont, int index) {
  return (pCont.playingIndex.value == index)
      ? (pCont.isPlaying.value
          ? (pCont.isBuffering.value
                  ? loadingIndicator(color: red, radius: 10)
                  : Image.asset(
                      pauseImg,
                      width: 16,
                    )
              // Icon(
              //     Icons.pause,
              //     size: 20,
              //   ),
              )
          : Image.asset(
              playImg,
              width: 20,
            )) //const Icon(Icons.play_arrow))
      : Image.asset(
          playImg,
          width: 20,
        );
}
