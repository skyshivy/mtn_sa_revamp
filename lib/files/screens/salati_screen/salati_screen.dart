import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

import 'package:responsive_builder/responsive_builder.dart';

class SalatiScreen extends StatelessWidget {
  late BuildContext? ctx;
  late SizingInformation si;

  SalatiScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      si = sizingInformation;
      return SingleChildScrollView(
        child: itemContainer(),
      );
    });
  }

  Column itemContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            headerImageView(),
            si.isMobile ? SizedBox() : CustomTopHeaderView(title: salatiStr.tr),
            titleAndSubtitle(),
            playButton(),
            const SizedBox(height: 30),
            buyButton(),
          ],
        ),
        SizedBox(height: si.isMobile ? 30 : 80),
        Column(
          children: [
            bottomButtonSection(),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget headerImageView() {
    return Image.asset(
      salatiHeaderImage,
      height: si.isMobile ? 200 : 300,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget titleAndSubtitle() {
    return SizedBox(
      width: si.isMobile ? double.infinity : 590,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            CustomText(
              title: aReminderFullOfBenStr,
              fontName: FontName.ztbold,
              fontSize: si.isMobile ? 18 : 22,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              alignment: TextAlign.center,
              title: salatiDescriptionStr,
              fontName: FontName.ztbold,
              fontSize: si.isMobile ? 12 : 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget playButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: si.isMobile
            ? const BoxDecoration()
            : BoxDecoration(
                color: Colors.white,
                border: Border.all(color: red),
              ),
        height: 50,
        width: 50,
        child: Center(
          child: Icon(
            Icons.play_arrow,
            size: 30,
            color: si.isMobile ? darkGreen : red,
          ),
        ),
      ),
    );
  }

  Widget playerIndicatorView() => Center(
          child: SizedBox(
        height: 30,
        width: 30,
        child: CupertinoActivityIndicator(
          radius: 15,
          color: darkGreen,
        ),
      ));

  Widget buyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
        onTap: () {
          onBuyButtonAction();
        },
        child: Container(
          width: si.isMobile ? double.infinity : 200,
          height: si.isMobile ? 40 : 35,
          decoration: BoxDecoration(
            //gradient: customGredient(),
            borderRadius: BorderRadius.circular(4),
            color: si.isMobile ? darkGreen : red,
          ),
          child: Center(
            child: CustomText(
              title: subscribeStr,
              fontName: FontName.ztbold,
              textColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtonSection() {
    return SizedBox(
      width: si.isMobile ? double.infinity : 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          genericButton(wishlistImage, wishlistStr, action: () {
            print("genric button");
          }),
          // genericButton(tellafriendImage, tellFriendStr,
          //     action: onTellAFriendButtonAction),
          genericButton(giftImage, giftStr, action: onGiftButtonAction),
          //genericButton("shareR", 'Share', action: onShareButtonAction),
        ],
      ),
    );
  }

  Container activityIndiactor() {
    return Container(
      height: 50,
      width: 70,
      color: Colors.transparent,
      child: const Center(
          child: CupertinoActivityIndicator(
        radius: 10,
      )),
    );
  }

  Widget genericButton(String imgName, String name, {Function()? action}) {
    return InkWell(
      onTap: () {
        action!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: si.isMobile ? Colors.transparent : Colors.white,
          boxShadow: si.isMobile
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 1,
                  ),
                ],
        ),
        width: 70,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imgName,
                color: Colors.black,
                height: 15,
                width: 15,
              ),
              const SizedBox(height: 5),
              CustomText(
                title: name,
                fontSize: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onBuyButtonAction() {
    print("on Buy Button Action");
  }

  void onPlayButtonAction() async {
    // var url = item.toneIdStreamingUrl ??
    //     'https://www.kozco.com/tech/piano2-Audacity1.2.5.mp3';
    // print("on Play Button Action ");

    // value.isPlaying ? await stopPlayingUrl(value) : value.playUrl(url);
    //value.stopPlay();
  }

  Future<Set<dynamic>> stopPlayingUrl() async {
    return {
      await Future.delayed(Duration(milliseconds: 1)),
    };
  }

  void onWishListButtonAction() {
    print("on WishList Button Action");
  }

  onTellAFriendButtonAction() {
    print("on TellAFriend Button Action");
  }

  onGiftButtonAction() {
    print("on Gift Button Action");
  }

  onShareButtonAction() {
    //Player.getInstance().stop();
    print("on Share Button Action");
  }
}
