import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BuyButton extends StatelessWidget {
  PlayerController playerController = Get.find();
  final TuneInfo? info;
  final int index;
  late BuildContext context;
  BuyButton({super.key, this.info, required this.index});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return buyButtonWidget();
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     // Expanded(child: playButtonWidget(index)),
    //     // const SizedBox(width: 10),
    //     Expanded(child: buyButtonWidget()),
    //   ],
    // );
  }

/*
  Widget playButtonWidget(int index) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return CustomButton(
            fontName: si.isMobile ? FontName.abook : FontName.abook,
            fontSize: si.isMobile ? 12 : 16,
            titlePadding: const EdgeInsets.all(4),
            borderColor: red,
            leftWidget: playAndPauseButtonIcon(index),
            title: playButtonTitleWidget(index),
            onTap: () {
              playerController.playUrl(info?.toneIdStreamingUrl ?? '', index);
              info?.isPlaying = !(info?.isPlaying ?? false);
            },
          );
        });
      },
    );
  }

  String playButtonTitleWidget(int index) {
    return (playerController.playingIndex.value == index)
        ? (playerController.isPlaying.value
            ? (playerController.isBuffering.value ? "" : playingStr)
            : playStr)
        : playStr;
  }

  Widget playAndPauseButtonIcon(int index) {
    return (playerController.playingIndex.value == index)
        ? (playerController.isPlaying.value
            ? (playerController.isBuffering.value
                ? loadingIndicator(color: red, radius: 10)
                : const Icon(
                    Icons.pause,
                    size: 20,
                  ))
            : const Icon(Icons.play_arrow))
        : const Icon(Icons.play_arrow);
  }
*/
  Widget buyButtonWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return
            //Container(color: red, child: Text(okStr));

            CustomButton(
          height: 30,
          onTap: () {
            print("Buy button");
            BuyTuneScreen().show(context, info);
          },
          color: red,
          //borderColor: red,

          titlePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          fontName: si.isMobile ? FontName.abook : FontName.aheavy,
          fontSize: si.isMobile ? 12 : 16,
          // leftWidget: Image.asset(
          //   buyImg,
          //   height: 20,
          //   width: 20,
          // ),
          title: buyNowStr,
          textColor: white,
        );
      },
    );
  }
}
