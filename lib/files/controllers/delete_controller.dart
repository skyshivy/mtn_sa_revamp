import 'package:get/get.dart';

class DeleteController extends GetxController {
  RxBool isAnimating = false.obs;
  //late AnimationController animationController;
  @override
  void onInit() {
    // animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  animate() {
    isAnimating.value = !isAnimating.value;
  }
}
