import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';

import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';

import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/reusable_view/buttons/buy_button.dart';
import 'package:mtn_sa_revamp/files/reusable_view/buttons/gift_button.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/buy_play_button.dart';

import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_more_button.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/popover_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeTuneCell extends StatelessWidget {
  final int index;
  final TuneInfo info;
  final bool isWishlist;
  final SizingInformation si;
  final Function()? onTap;
  final Widget? buttomButtonWidget;
  final Widget? moreButtonWidget;

  //late SizingInformation si;
  const HomeTuneCell({
    super.key,
    this.isWishlist = false,
    required this.index,
    required this.info,
    this.onTap,
    this.moreButtonWidget,
    this.buttomButtonWidget,
    required this.si,
  });
  @override
  Widget build(BuildContext context) {
    return SelectionArea(onSelectionChanged: (value) {
      if (value?.plainText.isEmpty ?? true) {
      } else {
        Clipboard.setData(ClipboardData(text: value?.plainText ?? ''));
      }
    }, child: ResponsiveBuilder(
      builder: (context, si) {
        return InkWell(
          onTap: onTap,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: decoration(),
            child: mainList(),
          ),
        );
      },
    ));
  }

  Column mainList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: tuneImageWidget(index)),
        bottomSection(index),
      ],
    );
  }

  Widget tuneImageWidget(int index) {
    return Stack(
      children: [
        customImage(
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
    return Obx(() {
      return InkWell(
        onTap: () {
          playerController.playUrl(info, index);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17), color: white),
          height: 35,
          width: 35,
          child: Center(
            child: (info?.toneId ?? '') == playerController.toneId
                ? playerController.isPlaying.value
                    ? Image.asset(pauseImg, height: 20)
                    : Image.asset(playImg, height: 20)
                : playerController.isPlaying.value
                    ? Image.asset(playImg, height: 20)
                    : Image.asset(playImg, height: 20),
          ),
        ),
      );
    });
  }

  Widget likeAndMoreWidget() {
    return Visibility(
      visible: appCont.tuneCategoryid != info?.categoryId,
      child: si.isMobile
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                likeButton(),
                moreButton(),
              ],
            ),
    );
  }

  Widget likeButton() {
    return SizedBox();
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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return InkWell(
          onTap: () {
            popoverView(context, () {
              if (isWishlist) {
                WishlistController wishCont = Get.find();
                wishCont.deleteFromWishlistAction(info ?? TuneInfo(), index);
              } else {
                RecoController recoController = Get.find();
                recoController.wishlistTapped(info);
              }
            }, isWishlist: isWishlist);

            printCustom("More button tapped isWishlist $isWishlist");
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17), color: Colors.white38),
            height: 35,
            width: 34,
            child: Center(
              child: Image.asset(
                moreHorzontalImg,
                width: 20,
              ),
            ),
          ),
        );
      },
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
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          homeCellTitleSubTilte(
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
          buttomButtonWidget ?? giftAndBuyButton(si)
          // BuyAndPlayButton(
          //   info: info,
          //   index: index,
          // ),
        ],
      ),
    );
  }

  Widget giftAndBuyButton(SizingInformation si) {
    bool isNameTune = (info?.categoryId != appCont.tuneCategoryid);
    return Row(
      children: [
        isNameTune ? Expanded(child: giftButton(si, info)) : const SizedBox(),
        const SizedBox(width: 8),
        Expanded(child: buyButton(si, info ?? TuneInfo()))
      ],
    );
  }
}
