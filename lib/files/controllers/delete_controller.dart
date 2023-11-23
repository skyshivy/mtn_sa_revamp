import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  RxBool isAnimating = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  startAnimation() {
    isAnimating.value = !isAnimating.value;
  }
}
