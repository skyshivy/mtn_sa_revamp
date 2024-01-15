import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class BuyAndPlayButton extends StatelessWidget {
  final PlayerController playerController = Get.find();
  final TuneInfo? info;
  final int index;
  late BuildContext context;
  bool isNameTune = false;
  BuyAndPlayButton({super.key, this.info, required this.index});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    isNameTune = (info?.categoryId != appCont.tuneCategoryid);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isNameTune ? Expanded(child: giftButton()) : const SizedBox(),
        SizedBox(width: isNameTune ? 10 : 0),
        Expanded(child: buyButtonWidget()),
      ],
    );
  }

  Widget giftButton() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomButton(
          leftWidget: SvgPicture.asset(
            giftTuneSvg,
            height: si.isMobile ? 15 : 18,
            width: si.isMobile ? 15 : 18,
          ), //Image.asset(giftTuneSvg),
          fontSize: si.isMobile ? 13 : 15,
          titlePadding: const EdgeInsets.only(top: 4, left: 4),
          title: giftStr.tr,
          fontName: si.isMobile ? FontName.medium : FontName.bold,
          borderColor: red,
          onTap: () {
            if (StoreManager().isLoggedIn) {
              Get.dialog(Center(
                child: GiftTuneView(
                  info: info ?? TuneInfo(),
                ),
              ));
            } else {
              Get.dialog(
                  CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
            }
          },
        );
      },
    );
  }

  Widget playButtonWidget(int index) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return CustomButton(
            fontName: si.isMobile ? FontName.medium : FontName.medium,
            fontSize: si.isMobile ? 12 : 16,
            titlePadding: const EdgeInsets.all(4),
            borderColor: red,
            leftWidget: playAndPauseButtonIcon(index),
            title: playButtonTitleWidget(index),
            onTap: () {
              playerController.playUrl(info, index);
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
            ? (playerController.isBuffering.value ? "" : playingStr.tr)
            : playStr.tr)
        : playStr.tr;
  }

  Widget playAndPauseButtonIcon(int index) {
    return (playerController.playingIndex.value == index)
        ? (playerController.isPlaying.value
            ? (playerController.isBuffering.value
                ? loadingIndicator(color: red, radius: 10)
                : Image.asset(
                    pauseImg,
                    width: 18,
                  ))
            // const Icon(
            //     Icons.pause,
            //     size: 20,
            //   ))
            : Image.asset(
                playImg,
                width: 18,
              )) //const Icon(Icons.play_arrow))
        : Image.asset(
            playImg,
            width: 18,
          ); //const Icon(Icons.play_arrow);
  }

  Widget buyButtonWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CustomButton(
          onTap: () {
            printCustom("Buy button");
            BuyTuneScreen().show(context, info);
          },
          color: blue,
          titlePadding: const EdgeInsets.only(top: 4, left: 4),
          fontName: si.isMobile ? FontName.medium : FontName.bold,
          fontSize: si.isMobile ? 13 : 15,
          leftWidget: Image.asset(
            buyImg,
            height: si.isMobile ? 15 : 18,
            width: si.isMobile ? 15 : 18,
          ),
          title: buyStr.tr,
          textColor: white,
        );
      },
    );
  }
}
