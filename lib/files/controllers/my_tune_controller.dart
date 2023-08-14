import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/view_model/my_tune_playing_vm.dart';

class MyTuneController extends GetxController {
  RxBool isLoadingPlaying = false.obs;
  RxBool isSuffle = false.obs;
  RxBool switchEnabled = false.obs;
  RxList<ListToneApk> playingList = <ListToneApk>[].obs;

  getPlayingTuneList() async {
    isLoadingPlaying.value = true;
    playingList.value = <ListToneApk>[];
    PlayingTuneModel? playingTune =
        await MyTunePlayingVM().getPlayingTuneListApiCall();

    if (playingTune != null) {
      isSuffle.value = playingTune.isSuffle!;
      playingList.value = playingTune.responseMap?.listToneApk ?? [];
    }
    isLoadingPlaying.value = false;
  }
}
