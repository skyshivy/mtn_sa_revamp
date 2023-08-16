import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class BuyAndPlayButton extends StatelessWidget {
  PlayerController playerController = Get.find();
  final TuneInfo? info;
  final int index;
  late BuildContext context;
  BuyAndPlayButton({super.key, this.info, required this.index});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: playButtonWidget(index)),
        const SizedBox(width: 10),
        Expanded(child: buyButtonWidget()),
      ],
    );
  }

  Widget playButtonWidget(int index) {
    return CustomButton(
      fontName: FontName.medium,
      fontSize: 16,
      titlePadding: const EdgeInsets.all(4),
      borderColor: red,
      leftWidget: Obx(() {
        return (playerController.playingIndex.value == index)
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow);
      }),
      title: playStr,
      onTap: () {
        // if ((playerController.isPlaying.value)) {
        //   playerController.pause();
        // } else {
        playerController.playUrl(info?.toneIdStreamingUrl ?? '', index);
//        }

        info?.isPlaying = !(info?.isPlaying ?? false);
      },
    );
  }

  Widget buyButtonWidget() {
    return CustomButton(
      onTap: () {
        print("Buy button");
        BuyTuneScreen().show(context, info);
      },
      color: yellow,
      titlePadding: const EdgeInsets.all(4),
      fontName: FontName.bold,
      fontSize: 16,
      leftWidget: Image.asset(
        buyImg,
        height: 20,
        width: 20,
      ),
      title: buy,
    );
  }
}
