import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

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

  filePicked() {
    checkSubmitButton();
  }

  filePicking() {
    isPicked.value = false;
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
    tuneName.value = '';
    isPlaying.value = false;
    checkSubmitButton();
  }
}
