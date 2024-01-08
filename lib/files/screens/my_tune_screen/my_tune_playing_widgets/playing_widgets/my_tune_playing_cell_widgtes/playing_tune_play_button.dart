import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget playingTunePlayButton(TuneInfo info, int index) {
  PlayerController pCont = Get.find();
  return Obx(
    () {
      return CustomButton(
        height: 40,
        width: 40,
        color: blue,
        leftWidget: _playAndPauseButtonIcon(pCont, index),
        // Icon(
        //   Icons.play_arrow,
        //   color: white,
        // ),
        onTap: () {
          pCont.playUrl(info, index);
        },
      );
    },
  );
}

Widget _playAndPauseButtonIcon(PlayerController pCont, int index) {
  return (pCont.playingIndex.value == index)
      ? (pCont.isPlaying.value
          ? (pCont.isBuffering.value
              ? loadingIndicator(color: white, radius: 10)
              : Image.asset(
                  pauseImg,
                  width: 20,
                ))
          // const Icon(
          //     Icons.pause,
          //     size: 20,
          //     color: white,
          //   ))
          : Image.asset(
              playImg,
              width: 20,
            ))
      // const Icon(
      //     Icons.play_arrow,
      //     color: white,
      //   ))
      : Image.asset(
          playImg,
          width: 20,
        );
  // const Icon(
  //     Icons.play_arrow,
  //     color: white,
  //   );
}
