import 'package:get/get.dart';

class DeleteController extends GetxController {
  RxBool isCHanged = false.obs;

  animate() {
    isCHanged.value = !isCHanged.value;
  }
}
