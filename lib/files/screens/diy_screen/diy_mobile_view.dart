import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/diy_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class DIYMobileView extends StatelessWidget {
  final DiyController cont = Get.find();

  DIYMobileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () {
          return cont.isRecordTapped.value
              ? recordingAudioWidget(context)
              : preRecordContainerView();
        },
      ),
    );
  }

  Widget recordingAudioWidget(
    BuildContext context,
  ) {
    var wid = MediaQuery.of(context).size.width - 75;
    var wid1 = wid - 50;
    var wid2 = wid - 100;
    var wid3 = wid - 150;
    var wid4 = wid - 200;
    var wid5 = wid - 250;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Center(
              child: Container(
            height: wid,
            width: wid,
            decoration: boxDeco(
              wid / 2,
              darkGreen.withOpacity(cont.opacity - 0.9), //(0.1),
            ),
            child: customCircle(
              wid1,
              darkGreen.withOpacity(cont.opacity - 0.7),
              customCircle(
                wid2,
                darkGreen.withOpacity(cont.opacity - 0.5), //(0.4),
                customCircle(
                  wid3,
                  darkGreen.withOpacity(cont.opacity - 0.3), //(0.6),
                  customCircle(
                    wid4,
                    darkGreen.withOpacity(cont.opacity - 0.1),
                    circleCenterWidget(wid5),
                  ),
                ),
              ),
            ),
          )),
        ),
        CustomText(
          title: listningStr,
          fontName: FontName.aheavy,
        )
      ],
    );
  }

  Center customCircle(double width, Color color, Widget? widget) {
    return Center(
      child: Container(
        height: width,
        width: width,
        decoration: boxDeco(width / 2, color),
        child: widget,
      ),
    );
  }

  Center circleCenterWidget(double wid5) {
    return Center(
      child: Container(
        height: wid5,
        width: wid5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((wid5) / 2),
          color: darkGreen.withOpacity(1),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 0)
          ],
        ),
        child: Obx(
          () {
            return IconButton(
              onPressed: () {
                cont.audioRecordStopped();
                print("+++++321");
              },
              icon: Icon(
                Icons.stop_rounded,
                color: Colors.white,
                size: 35,
              ),
            );
          },
        ),
      ),
    );
  }

  // Container waveWidget(double wid1) {
  //   return Container(
  //     height: wid1,
  //     width: wid1,
  //     decoration: boxDeco((wid1) / 2, CColor.green),
  //   );
  // }

  Column preRecordContainerView() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        CustomText(
          title: diyDescriptionStr,
          fontSize: 12,
        ),
        Obx(() {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: recordGreenContainerView(),
              ),
              cont.isRecordStopped.value
                  ? afterRecordWidget()
                  : CustomText(
                      title: tapToRecordStr,
                      fontName: FontName.aheavy,
                      textColor: darkGreen,
                    )
            ],
          );
        })
      ],
    );
  }

  Widget afterRecordWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        recordButtonAction(),
        tuneNameTextField(),
        const SizedBox(height: 10),
        termsAndCondition(),
        buyButton(),
      ],
    );
  }

  Widget termsAndCondition() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Obx(() {
            return Checkbox(
              checkColor: Colors.black,
              value: cont.checkBox.value,
              onChanged: (v) {
                print(" ${v}");
                cont.updateCheckBox();
              },
            );
          }),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: iHaveReadtermsStr,
                  style: TextStyle(
                      fontFamily: FontName.aheavy.name,
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(text: " "),
                TextSpan(
                  text: termsStr,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print("Diy Terms & Conditions");
                    },
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: FontName.aheavy.name,
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
  // Widget termsButtonWidget() {
  //   return Column(
  //     children: [
  //       CustomText(title: "terms and condition button"),
  //     ],
  //   );
  // }

  Widget tuneNameTextField() {
    return Column(
      children: [
        TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: 'Enter tune name',
              hintStyle: TextStyle(
                fontFamily: FontName.aheavy.name,
              )),
        ),
        Container(
          color: Colors.grey,
          height: 1,
        )
      ],
    );
  }

  Widget buyButton() {
    return CustomButton(
      title: "Buy",
      textColor: Colors.white,
      color: cont.isReadyForUpload ? darkGreen : Colors.grey,
    );
  }

  TextButton recordButtonAction() {
    return TextButton(
      onPressed: () {
        cont.recordAgainTapped();
      },
      child: Column(
        children: [
          CustomText(
            title: "Record again",
            textColor: darkGreen,
          ),
        ],
      ),
    );
  }

  Widget recordGreenContainerView() {
    return Container(
      decoration: boxDeco(90, darkGreen.withOpacity(0.6)),
      height: 180,
      width: 180,
      child: Center(
        child: Container(
          decoration: boxDeco(50, darkGreen),
          height: 100,
          width: 100,
          child: recordButtonWidget(),
        ),
      ),
    );
  }

  Widget recordButtonWidget() {
    imageNameLoad() {
      return cont.isRecordStopped.value
          ? cont.isPlaying.value
              ? "pause.png"
              : "playGreen.png"
          : cont.isRecordTapped.value
              ? ''
              : 'audio_record.png';
    }

    return IconButton(
        onPressed: () {
          print("+++++++123");
          if (cont.isRecordStopped.value) {
            if (cont.isPlaying.value) {
              print("pause button tapped");
              //value.pauseTapped();
            } else {
              print("Play button tapped");
              //value.playTapped();
            }
          } else {
            //value.recordTapped();
            print("Started recording");
          }
        },
        icon: Icon(Icons.play_arrow));
  }

  Decoration boxDeco(double radius, Color color) {
    return BoxDecoration(
      gradient: customGredient(),
      borderRadius: BorderRadius.circular(radius),
      color: color,
    );
  }
}
