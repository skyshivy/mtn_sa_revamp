import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  RxBool isAnimating = false.obs;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
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
    if (animationController.isAnimating) {
      isAnimating.value = false;
      animationController.stop();
    } else {
      isAnimating.value = true;
      animationController.forward();
      animationController.repeat();
    }
  }
}
