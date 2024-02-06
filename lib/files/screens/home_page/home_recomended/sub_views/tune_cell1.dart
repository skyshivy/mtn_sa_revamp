import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';

import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/popover_view.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeTuneCell1 extends StatefulWidget {
  final int index;

  const HomeTuneCell1({
    super.key,
    required this.index,
  });
  @override
  State<StatefulWidget> createState() => _HomeTuneCell1State();
}

class _HomeTuneCell1State extends State<HomeTuneCell1> {
  TuneInfo? info;
  @override
  Widget build(BuildContext context) {
    final CategoryController cont = Get.find();
    info = cont.searchList[widget.index];
    return SelectionArea(
      child: GestureDetector(
        onTap: () {
          printCustom("Tapped ${cont.si.isMobile}");
          cont.si.isMobile
              ? pushToTunePreView(context, cont.searchList, widget.index)
              : printCustom("obj");
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [
                BoxShadow(
                  color: cellShadowColor,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                info?.toneIdpreviewImageUrl ?? '',
                                maxHeight: 2,
                                maxWidth: 2))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Visibility(
                          visible: appCont.tuneCategoryid != info?.categoryId,
                          child: cont.si.isMobile
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    ResponsiveBuilder(
                                      builder: (context, sizingInformation) {
                                        return GestureDetector(
                                          onTap: () {
                                            popoverView(context, () {
                                              if (true) {
                                                WishlistController wishCont =
                                                    Get.find();
                                                wishCont
                                                    .deleteFromWishlistAction(
                                                        info ?? TuneInfo(),
                                                        widget.index);
                                              }
                                              // else {
                                              //   RecoController recoController =
                                              //       Get.find();
                                              //   recoController
                                              //       .wishlistTapped(info);
                                              // }
                                            }, isWishlist: true);

                                            printCustom(
                                                "More button tapped isWishlis");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                color: Colors.black38),
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
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Expanded(
                          child: Center(child: Center(child: playButton()))),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                ],
              )),
              _BottomSection(
                index: widget.index,
              ),
              _GiftAndBuyButton(
                si: cont.si,
                index: widget.index,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playButton() {
    return Obx(() {
      return InkWell(
        onTap: () {
          playerController.playUrl(info, widget.index);
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
}

class _BottomSection extends StatelessWidget {
  final int index;

  const _BottomSection({required this.index});
  @override
  Widget build(BuildContext context) {
    CategoryController cont = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onDoubleTap: () {
            Clipboard.setData(ClipboardData(
                    text: cont.searchList[index].toneName ??
                        cont.searchList[index].contentName ??
                        ""))
                .then((_) {
              Get.snackbar(
                  "Copied",
                  cont.searchList[index].toneName ??
                      cont.searchList[index].contentName ??
                      "",
                  backgroundColor: white,
                  duration: const Duration(seconds: 2));
            });

            printCustom(
                "Tapped text is ${cont.searchList[index].toneName ?? cont.searchList[index].contentName ?? ""}");
          },
          child: Tooltip(
            message: cont.searchList[index].toneName ?? '',
            waitDuration: const Duration(milliseconds: 600),
            child: CustomText(
                title: cont.searchList[index].toneName ?? '', maxLine: 1),
          ),
        ),
        GestureDetector(
            onDoubleTap: () {
              Clipboard.setData(ClipboardData(
                      text: cont.searchList[index].artistName ??
                          cont.searchList[index].artist ??
                          ' ARtist name here'))
                  .then((_) {
                Get.snackbar(
                    "Copied",
                    cont.searchList[index].artistName ??
                        cont.searchList[index].artist ??
                        ' ARtist name here',
                    backgroundColor: white,
                    duration: const Duration(seconds: 2));
              });

              printCustom(
                  "Tapped text is ${cont.searchList[index].toneName ?? cont.searchList[index].contentName ?? ""}");
            },
            child: Tooltip(
              waitDuration: const Duration(milliseconds: 600),
              message: cont.searchList[index].artistName ?? '',
              child: CustomText(
                maxLine: 1,
                title: cont.searchList[index].artistName ?? '',
              ),
            )),
        GestureDetector(
          onDoubleTap: () {
            Clipboard.setData(
                    ClipboardData(text: cont.searchList[index].toneId ?? ''))
                .then((_) {
              Get.snackbar("Copied", cont.searchList[index].toneId ?? '',
                  backgroundColor: white, duration: const Duration(seconds: 2));
            });
          },
          child: Tooltip(
            waitDuration: const Duration(milliseconds: 600),
            message: cont.searchList[index].toneId ?? '',
            child: CustomText(
                title:
                    "${tuneCodeStr.tr} : ${cont.searchList[index].toneId ?? ''}"),
          ),
        )
      ],
    );
  }
}

class _GiftAndBuyButton extends StatelessWidget {
  final SizingInformation si;

  final int index;
  const _GiftAndBuyButton({required this.si, required this.index});

  @override
  Widget build(BuildContext context) {
    final CategoryController cont = Get.find();
    bool isNameTune =
        (cont.searchList[index].categoryId != appCont.tuneCategoryid);
    return Row(
      children: [
        isNameTune
            ? Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (StoreManager().isLoggedIn) {
                        Get.dialog(Center(
                          child: GiftTuneView(
                            info: cont.searchList[index],
                          ),
                        ));
                      } else {
                        Get.dialog(CustomAlertView(
                            title: featureIsAvailableForLoggedInStr.tr));
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white,
                          border: Border.all(color: red)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              giftTuneSvg,
                              height: si.isMobile ? 15 : 18,
                              width: si.isMobile ? 15 : 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4, top: 3),
                              child: CustomText(
                                  title: giftStr.tr,
                                  fontSize: si.isMobile ? 13 : 15,
                                  textColor: black,
                                  fontName: si.isMobile
                                      ? FontName.medium
                                      : FontName.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: blue,
            ),
            height: 40,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  printCustom("Buy button");
                  BuyTuneScreen().show(cont.searchList[index]);
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        buyImg,
                        height: si.isMobile ? 15 : 18,
                        width: si.isMobile ? 15 : 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 4),
                        child: CustomText(
                            title: buyStr.tr,
                            fontSize: si.isMobile ? 13 : 15,
                            textColor: white,
                            fontName:
                                si.isMobile ? FontName.medium : FontName.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
