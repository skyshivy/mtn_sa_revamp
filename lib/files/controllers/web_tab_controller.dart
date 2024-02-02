import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/main.dart';

class WebTabController extends GetxController {
  RxInt index = 0.obs;

  loadPage(int index1) {
    index.value = index1;
    playerController.stop();
    printCustom("Selected tab $index1");
  }
}
