import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';

class WebTabController extends GetxController {
  RxInt index = 0.obs;
  PlayerController controller = Get.find();

  loadPage(int index1) {
    index.value = index1;
    controller.stop();
    print("Selected tab $index1");
  }
}
