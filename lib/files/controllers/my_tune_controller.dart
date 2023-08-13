import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/view_model/my_tune_playing_vm.dart';

class MyTuneController extends GetxController {
  RxBool isSuffle = false.obs;
  getPlayingList() async {
    var re = await MyTunePlayingVM().getPlayingTuneList();
    print("Resu ========== $re");
  }
}
