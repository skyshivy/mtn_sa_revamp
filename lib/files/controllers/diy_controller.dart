import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class DiyController extends GetxController {
  RxBool enableSubmitButton = false.obs;
  RxBool checkBox = false.obs;
  RxBool isPicked = false.obs;
  RxBool isPlaying = false.obs;
  RxBool isRecordTapped = false.obs;
  RxString tuneName = ''.obs;
  int curTime = 0;
  double opacity = 10.3;
  bool isReadyForUpload = false;
  RxBool isRecordStopped = false.obs;
  int maxime = 0;
  Uint8List? audioData;
  String fileName = 'file name here';

  filePicked() {
    checkSubmitButton();
  }

  filePicking() {
    isPicked.value = false;
  }

  checkSubmitButton() {
    if ((checkBox.value) && (tuneName.isNotEmpty) && (fileName.isNotEmpty)) {
      enableSubmitButton.value = true;
      print("checkSubmitButton  == ${enableSubmitButton.value}");
    } else {
      enableSubmitButton.value = false;
    }
  }

  playPause(bool value) {
    isPlaying.value = value;
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
    isPlaying.value = false;
    checkSubmitButton();
  }
}
