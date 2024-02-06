import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/music_box_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicBoxCard extends StatelessWidget {
  final MusicBoxSearchList info;

  const MusicBoxCard({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: greyLight,
          border: Border.all(color: grey)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageIconWidget(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  tuneDetailWidget(context),
                  bottomButtonContainer(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget playButton() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return CustomButton(
            width: 35,
            leftWidget: (info.previewContent ?? '') == playerController.toneId
                ? playerController.isPlaying.value
                    ? Image.asset(pauseImg,
                        height: 20) //const Icon(Icons.pause, size: 20)
                    : Image.asset(playImg,
                        height:
                            20) //const Icon(Icons.play_arrow_rounded, size: 20)
                : playerController.isPlaying.value
                    ? Image.asset(playImg,
                        height:
                            20) //const Icon(Icons.play_arrow_rounded, size: 20)
                    : Image.asset(playImg,
                        height:
                            20), //const Icon(Icons.play_arrow_rounded, size: 20),
            onTap: () {
// this.id,
//     this.contentId,
//     this.contentName,
//     this.path,
//     this.album,
//     this.artist,
//     this.msisdn,
//     this.createdDate,
//     this.wishListType,
//     this.albumName,
//     this.artistName,
//     this.categoryId,
//     this.downloadCount,
//     this.likeCount,
//     this.previewImageUrl,
//     this.toneId,
//     this.toneIdStreamingUrl,
//     this.toneIdpreviewImageUrl,
//     this.toneName,
//     this.toneUrl,
//     this.price,
//     this.expiryDate,
//     this.status,
//     this.isCopy,
//     this.isGift,

              playerController.playUrl(
                  TuneInfo(
                      toneIdStreamingUrl: info.previewContent,
                      toneId: info.entityId),
                  0);
            },
          );
        });
      },
    );
  }

  Widget imageIconWidget() {
    List<String>? abc = (info.channelName)?.split(" ");
    String sortName = '';
    try {
      sortName = (abc?[0] ?? '')[0];
    } catch (e) {}
    try {
      sortName += " ${(abc?[1] ?? '')[0]}";
    } catch (e) {}
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
          child: CustomText(
        title: sortName,
        textColor: white,
        fontName: FontName.bold,
        fontSize: 18,
      )),
    );
  }

  Widget tuneDetailWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              CustomText(
                title: info.channelName ?? '',
                maxLine: 1,
              ),
              CustomText(
                title: info.description ?? '',
                maxLine: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget viewButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        context.goNamed(musicDetailListGoRoute,
            queryParameters: {"toneCode": info.toneCode, "type": info.type});
        printCustom("View detail called");
      },
      height: 40,
      leftWidget: SvgPicture.asset(
        viewSvg,
        height: 15,
      ),
    );
  }

  // Widget playButton() {
  //   return SizedBox(
  //       height: 40, child: Center(child: CustomText(title: "Play")));
  // }

  Widget bottomButtonContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //  playButton(),
            viewButton(context),
          ],
        ),
        Row(
          children: [
            // giftButton(),
            const SizedBox(width: 8),
            buyButton(context),
          ],
        ),
      ],
    );
  }

  Widget buyButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        BuyTuneScreen().show(
            TuneInfo(
              toneName: info.channelName,
              albumName: info.artistName,
              toneId: info.toneCode,
            ),
            isBuyMusicChannel: true);
        printCustom("buy taped");
      },
      titlePadding: const EdgeInsets.only(left: 4, top: 6),
      height: 40,
      leftWidget: Image.asset(
        buyImg,
        height: 20,
        color: black,
      ),
      title: buyStr,
    );
  }

  Widget giftButton() {
    return CustomButton(
      onTap: () {
        if (StoreManager().isLoggedIn) {
          Get.dialog(Center(
            child: GiftTuneView(
              info: TuneInfo(
                toneName: info.channelName,
                albumName: info.artistName,
                toneId: info.toneCode,
              ),
            ),
          ));
        } else {
          Get.dialog(
              CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
        }

        printCustom("Gift button");
      },
      titlePadding: const EdgeInsets.only(left: 2, top: 6),
      height: 40,
      leftWidget: SvgPicture.asset(
        giftTuneSvg,
        height: 20,
      ),
      title: giftStr,
    );
  }
}
