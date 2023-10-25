import 'package:flutter/material.dart';
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
  String fileName = 'file name here';
  checkSubmitButton() {
    print("Check submit button method");
  }

  recordAgainTapped() {
    print("recordAgainTapped 22");
  }

  updateCheckBox() {
    print("Update check box");
  }

  audioRecordStopped() {
    print("audioRecordStopped");
  }

  initialState() {
    print("initialState me");
  }
}
