import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/delete_popover.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/buy_play_button.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_more_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class HomeTuneCell extends StatelessWidget {
  final int index;
  final TuneInfo? info;
  final bool isWishlist;
  final Function()? onTap;
  final Widget? buttomButtonWidget;
  final Widget? moreButtonWidget;
  PlayerController pCont = Get.find();
  HomeTuneCell({
    super.key,
    this.isWishlist = false,
    required this.index,
    this.info,
    this.onTap,
    this.moreButtonWidget,
    this.buttomButtonWidget,
  });
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      onSelectionChanged: (value) {
        if (value?.plainText.isEmpty ?? true) {
        } else {
          Clipboard.setData(ClipboardData(text: value?.plainText ?? ''));
        }
      },
      child: InkWell(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: decoration(),
          child: mainList(),
        ),
      ),
    );
  }

  Column mainList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: tuneImageWidget(index)),
        bottomSection(index),
      ],
    );
  }

  Widget tuneImageWidget(int index) {
    return Stack(
      children: [
        CustomImage(
          url: info?.toneIdpreviewImageUrl ?? info?.previewImageUrl,
          index: index,
          gradient: customGredient(blackGredient, blackGredient),
        ),
        tuneImageTopLayer()
      ],
    );
  }

  Column tuneImageTopLayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        moreButtonWidget ??
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: likeAndMoreWidget(),
            ),
        Expanded(child: Center(child: Center(child: playButton()))),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget playButton() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return CustomButton(
            height: 35,
            width: 35,
            color: white,
            leftWidget:
                //Icon(Icons.play_arrow),

                (info?.toneId ?? '') == pCont.toneId
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
              pCont.playUrl(info, index);
            },
          );
        });
      },
    );
  }

  Widget likeAndMoreWidget() {
    return Visibility(
      visible: appCont.tuneCategoryid != info?.categoryId,
      child: ResponsiveBuilder(
        builder: (context, si) {
          return si.isMobile
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    likeButton(),
                    moreButton(),
                  ],
                );
        },
      ),
    );
  }

  Widget likeButton() {
    return SizedBox();
    (info?.likeCount == null)
        ? const SizedBox()
        : CustomButton(
            height: 30,
            color: Colors.white38,
            leftWidget: likeImage(),
            title: info?.likeCount ?? '0',
            titlePadding: const EdgeInsets.only(right: 8, left: 4),
            fontSize: 16,
            fontName: FontName.medium,
            textColor: white,
            onTap: () {
              printCustom("likeButton tapped");
            },
          );
  }

  Padding likeImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Image.asset(
        likeImg,
        height: 15,
        width: 15,
      ),
    );
  }

  Widget moreButton() {
    return HomeMoreButton(
      info: info,
      index: index,
      isWishlist: isWishlist,
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: cellShadowColor,
            spreadRadius: 2,
            blurRadius: 2,
          )
        ]);
  }

  Widget bottomSection(int index) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeCellTitleSubTilte(
                info: info,
                titleFontSize: si.isMobile ? 14 : null,
                subTitleFontSize: si.isMobile ? 12 : null,
              ),
              const SizedBox(height: 3),
              InkWell(
                onDoubleTap: () {
                  Clipboard.setData(ClipboardData(text: info?.toneId ?? ''))
                      .then((_) {
                    Get.snackbar("Copied", info?.toneId ?? '',
                        backgroundColor: white,
                        duration: const Duration(seconds: 2));
                  });
                },
                child: Tooltip(
                  waitDuration: const Duration(milliseconds: 600),
                  message: info?.toneId ?? '',
                  child: CustomText(
                    title: "${tuneCodeStr.tr} : ${info?.toneId ?? ''}",
                    fontSize: si.isMobile ? 12 : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              buttomButtonWidget ??
                  BuyAndPlayButton(
                    info: info,
                    index: index,
                  ),
            ],
          ),
        );
      },
    );
  }
}
