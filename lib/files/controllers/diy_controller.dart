import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';

class DiyController extends GetxController {
  RxBool enableSubmitButton = false.obs;
  RxBool checkBox = false.obs;
  RxBool isPicked = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isRecordTapped = false.obs;
  RxString tuneName = ''.obs;
  RxInt curTime = 0.obs;
  double opacity = 10.3;
  bool isReadyForUpload = false;
  RxBool isRecordStopped = false.obs;
  RxInt maxime = 0.obs;
  Uint8List? audioData;
  String fileName = '';
  RxBool fileUploading = false.obs;
  filePicked() {
    isPicked.value = true;
    fileUploading.value = false;
    checkSubmitButton();
  }

  filePicking() {
    isPicked.value = false;
    fileUploading.value = true;
  }

  checkSubmitButton() {
    print("checkBox.value = ${checkBox.value} ");
    print("tuneName.isNotEmpty = ${tuneName.isNotEmpty} =$tuneName ");
    print("fileName.isNotEmpty = ${fileName.isNotEmpty}  = $fileName");

    if ((checkBox.value) && (tuneName.isNotEmpty) && (fileName.isNotEmpty)) {
      enableSubmitButton.value = true;
      print("checkSubmitButton  == ${enableSubmitButton.value}");
    } else {
      enableSubmitButton.value = false;
    }
  }

  playFromData() {
    print("Play from data ${audioData}");
    //MtnAudioPlayer.instance.playByte(_buffer, (p0) => null, (p0, p1) => null)
    MtnAudioPlayer.instance.playByte(audioData!, (p0) {
      if (p0 == PlayerAction.paused) {
        isPlaying.value = false;
      } else {
        isPlaying.value = true;
      }
      print("= p0 = $p0");
    }, (p0, p1) {
      maxime.value = p0;
      try {
        curTime.value = p1.toInt();
      } catch (e) {
        print("erro at setting value for  cont.curTime");
      }

      //cont.maxAndMinUpdate();
    });
  }

  playPause(bool value) {
    isPlaying.value = value;
    if (value) {
      MtnAudioPlayer.instance.pause();
    } else {
      MtnAudioPlayer.instance.resume();
    }
  }

  recordAgainTapped() {
    print("recordAgainTapped 22");
  }

  updateCheckBox() {
    checkBox.value = !checkBox.value;
    checkSubmitButton();
  }

  audioRecordStopped() {
    print("audioRecordStopped");
  }

  updateTuneName(String name) {
    tuneName.value = name;
    checkSubmitButton();
  }

  initialState() {
    isPicked.value = false;
    checkBox.value = false;
    fileName = '';
    tuneName.value = '';
    fileUploading.value = false;
    isPlaying.value = false;
    MtnAudioPlayer.instance.stop();
    checkSubmitButton();
  }
}
