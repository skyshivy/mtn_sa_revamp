import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isCHanged = false.obs;
  late AnimationController animationController;
  @override
  void onInit() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
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

  animate() {
    isCHanged.value = !isCHanged.value;
  }
}
