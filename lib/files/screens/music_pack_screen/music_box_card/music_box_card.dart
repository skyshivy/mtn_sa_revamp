import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/music_box_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicBoxCard extends StatelessWidget {
  final MusicBoxSearchList info;

  final PlayerController pCont = Get.find();
  MusicBoxCard({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: greyLight,
          border: Border.all(color: grey)),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageIconWidget(),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: tuneDetailWidget(context)),
                  giftBuyWidget()
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
        return Visibility(
            visible: !si.isMobile,
            child: Obx(() {
              return CustomButton(
                width: 35,
                leftWidget: (info.previewContent ?? '') == pCont.toneId
                    ? pCont.isPlaying.value
                        ? Image.asset(pauseImg,
                            height: 20) //const Icon(Icons.pause, size: 20)
                        : Image.asset(playImg,
                            height:
                                20) //const Icon(Icons.play_arrow_rounded, size: 20)
                    : pCont.isPlaying.value
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

                  pCont.playUrl(
                      TuneInfo(
                          toneIdStreamingUrl: info.previewContent,
                          toneId: info.entityId),
                      0);
                },
              );
            }));
      },
    );
  }

  Widget imageIconWidget() {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(50),
      ),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            playButton(),
            viewButton(context),
          ],
        )
      ],
    );
  }

  Widget viewButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        context.goNamed(musicDetailListGoRoute,
            queryParameters: {"toneCode": info.toneCode, "type": info.type});
        print("View detail called");
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

  Widget giftBuyWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            CustomButton(
              titlePadding: EdgeInsets.only(left: 2, top: 6),
              height: 40,
              leftWidget: SvgPicture.asset(
                giftTuneSvg,
                height: 20,
              ),
              title: giftStr,
            ),
            const SizedBox(width: 8),
            CustomButton(
              titlePadding: EdgeInsets.only(left: 4, top: 6),
              height: 40,
              leftWidget: Image.asset(
                buyImg,
                height: 20,
                color: black,
              ),
              title: buyStr,
            ),
          ],
        ),
      ],
    );
  }
}
