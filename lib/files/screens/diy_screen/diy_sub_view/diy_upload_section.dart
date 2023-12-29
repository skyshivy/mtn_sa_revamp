import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/diy_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../../custom_files/time_formate.dart';

class DIYUploadSection extends StatelessWidget {
  //final DIYProvider diyProvider;
  DIYUploadSection({super.key});
  DiyController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Column(
          children: [
            dottedLineWidget(sizingInformation, context),
            termsAndCondition(sizingInformation),
            confirmButton(sizingInformation),
          ],
        );
      },
    );
  }

  Widget dottedLineWidget(SizingInformation si, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
          child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(si.isMobile ? 10 : 15),
              dashPattern: const [6, 4],
              strokeWidth: 1.2,
              child: Obx(() {
                return Container(
                  width: si.isMobile ? null : 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: cont.isPicked.value ? 10 : 25),
                    child: cont.isPicked.value
                        ? replaceWidget(si, context)
                        : browseWidget(si),
                  ),
                );
              })),
        ),
      ],
    );
  }

  Widget replaceWidget(SizingInformation si, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                maxLine: 3,
                alignment: TextAlign.left,
                title: cont.fileName,
                fontSize: si.isMobile ? 12 : 14,
              ),
            ),
            replaceButtonWidget(si)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        playAudioSection(si, context)
      ],
    );
  }

  Widget playAudioSection(SizingInformation si, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        playPauseButton(),
        SizedBox(
          width: 10,
        ),
        Expanded(child: progressBarWidget(si, context)),
      ],
    );
  }

  Widget playPauseButton() {
    return InkWell(
      hoverColor: transparent,
      onTap: () {
        if (!cont.isPlaying.value) {
          print("Data ==1 ");
          //Player.getInstance().playByte(value.audioData!, ((p0),(v,s) {}));
          //cont.playFromData();

          cont.playPause(true);
        } else {
          print("Data ==2 ");

          cont.playPause(false);
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(cont.isPlaying.value ? Icons.play_arrow : Icons.pause),
        ),
      ),
    );
  }

  Widget progressBarWidget(SizingInformation si, BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title:
                    "${TimeFormate.formatDuration(cont.curTime.value)}", //"${value.curTime}",
                fontSize: si.isMobile ? 10 : 12,
                fontName: FontName.abook,
                textColor: Colors.grey,
              ),
              CustomText(
                title:
                    "${TimeFormate.formatDuration(cont.maxime.value)}", //"${value.maxime}",
                fontSize: si.isMobile ? 10 : 12,
                fontName: si.isMobile ? FontName.abook : FontName.aheavy,
                textColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 10,
                child: Center(
                  child: SliderTheme(
                    child: Slider(
                      value: cont.curTime.toDouble(),
                      max: cont.maxime.toDouble(),
                      min: 0,
                      activeColor: red,
                      inactiveColor: darkGreen.withOpacity(0.3),
                      onChanged: (double value) {},
                    ),
                    data: SliderTheme.of(context).copyWith(
                      overlayShape: SliderComponentShape.noThumb,
                      trackHeight: 4,
                      thumbColor: Colors.transparent,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 0.0),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ],
      );
    });
  }

  Widget replaceButtonWidget(
    SizingInformation si,
  ) {
    return InkWell(
      hoverColor: transparent,
      onTap: () {
        print("Replace tapped");
        cont.initialState();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: red),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(
            title: replaceStr,
            fontSize: si.isMobile ? 12 : 14,
            fontName: si.isMobile ? FontName.abook : FontName.abook,
          ),
        ),
      ),
    );
  }

  Widget browseWidget(SizingInformation si) {
    return Row(
      children: [
        Row(
          children: [
            Obx(() {
              return cont.isPicked.value
                  ? afterPickFileWidget(si)
                  : beforePickFileWidget(si);
            }),
            const SizedBox(width: 10),
            Obx(() {
              return cont.fileUploading.value
                  ? afterFilePicktitleSubTitle(si)
                  : beforeFilePicktitleSubTitle();
            })
          ],
        ),
      ],
    );
  }

  Widget afterPickFileWidget(SizingInformation si) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: si.isMobile ? darkGreen : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Image.asset(
        diyMusicImg,
        color: si.isMobile ? Colors.white : Colors.black,
        height: 20,
        width: 20,
      )),
    );
  }

  Widget beforeFilePicktitleSubTitle() {
    return ResponsiveBuilder(builder: (context, si) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: dropYourFileStr,
            fontSize: si.isMobile ? 12 : 16,
          ),
          const SizedBox(height: 4),
          CustomText(
            title: supportMp3Str,
            fontSize: si.isMobile ? 10 : 14,
            textColor: subTitleColor,
            fontName: FontName.abook,
          ),
        ],
      );
    });
  }

  Widget afterFilePicktitleSubTitle(SizingInformation si) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "Uploading...".tr,
          fontName: FontName.aheavy,
          fontSize: si.isMobile ? 12 : 16,
          textColor: red,
        ),
        SizedBox(
          height: 2,
        ),
        CustomText(
          title: "",
          textColor: Colors.grey.withOpacity(0.5),
          fontSize: si.isMobile ? 10 : 14,
        ),
      ],
    );
  }

  CupertinoActivityIndicator loadingIndicator() => CupertinoActivityIndicator(
        color: red,
      );

  browseButtonTape() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        onFileLoading: (p0) {
          print("Staus is ${p0}");
          switch (p0) {
            case FilePickerStatus.picking:
              print("value.filePicking()");
              cont.filePicking();
              break;
            case FilePickerStatus.done:
              cont.isPicked.value = true;
              print(" FilePickerStatus.done ");
              break;
            default:
          }
        },
        type: FileType.custom,
        allowedExtensions: ['mp3', 'aac', 'amr', 'm4a', 'wav']);
    if (result == null) {
      print("value.filePicking();");
    } else {
      cont.fileName = result.files.first.name;
      cont.filePicked();
      cont.audioData = result.files.first.bytes;
      cont.playFromData();
    }
    cont.fileUploading.value = false;
    print("uploaded ${result?.names}");
  }

  Widget termsAndCondition(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: si.isMobile ? null : 400,
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
                    text: "I have read and agree to the".tr,
                    style: TextStyle(
                        fontFamily: FontName.aheavy.name,
                        fontSize: si.isMobile ? 11 : 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(text: " "),
                  TextSpan(
                    text: "Terms & Conditions".tr,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Diy Terms & Conditions");
                      },
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: FontName.aheavy.name,
                        fontSize: si.isMobile ? 11 : 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget confirmButton(SizingInformation si) {
    return SizedBox(
      width: si.isMobile ? null : 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Obx(() {
          return CustomButton(
            title: submitStr,
            textColor: cont.enableSubmitButton.value ? white : black,
            color: cont.enableSubmitButton.value
                ? darkGreen
                : Colors.grey.withOpacity(0.5),
            onTap: () {
              //Player.getInstance().stop();

              print("Submit ==== ${cont.enableSubmitButton}");
              cont.checkSubmitButton();
            },
          );
        }),
      ),
    );
  }

  Widget beforePickFileWidget(SizingInformation si) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(si.isMobile ? 15 : 10),
        color: si.isMobile ? darkGreen : Colors.grey.withOpacity(0.3),
      ),
      child: Center(
        child: InkWell(
          hoverColor: transparent,
          onTap: () async {
            browseButtonTape();
          },
          child: Image.asset(
            browseImg,
            //color: si.isMobile ? Colors.white : Colors.black,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
