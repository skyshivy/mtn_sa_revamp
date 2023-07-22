import 'package:get/get.dart';

class WebTabController extends GetxController {
  RxInt index = 0.obs;

  loadPage(int index1) {
    index.value = index1;
    print("Selected tab $index1");
  }
}
