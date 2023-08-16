import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/my_tune_playing_vm.dart';

class MyTuneController extends GetxController {
  RxBool isLoadingPlaying = false.obs;
  RxBool isLoadingTune = false.obs;
  RxBool isSuffle = false.obs;
  RxBool switchEnabled = false.obs;
  RxList<ListToneApk> playingList = <ListToneApk>[].obs;
  RxList<ListToneApk1> tuneList = <ListToneApk1>[].obs;

  getPlayingTuneList() async {
    isLoadingPlaying.value = true;
    playingList.value = <ListToneApk>[];
    getTuneList();
    PlayingTuneModel? playingTune =
        await MyTunePlayingVM().getPlayingTuneListApiCall();

    if (playingTune != null) {
      print("Is suffle status 1 ${playingTune.isSuffle!}");
      isSuffle.value = playingTune.isSuffle!;
      playingList.value = playingTune.responseMap?.listToneApk ?? [];
    }
    isLoadingPlaying.value = false;
  }

  getTuneList() async {
    tuneList.value = <ListToneApk1>[];
    isLoadingTune.value = true;
    Map<String, dynamic>? re = await ServiceCall().get(getMyTuneListUrl);
    if (re != null) {
      MyTuneListModel model = MyTuneListModel.fromJson(re);
      tuneList.value = model.responseMap?.listToneApk ?? [];
      print(
          "============== res ============ ${model.responseMap?.listToneApk}");
    }

    print("getTuneList  ${tuneList.length}");
    isLoadingTune.value = false;
  }

  Future<void> suffleTune() async {
    print("Suffle status");
    print("calling api ${switchEnabled}");
    var result = await MyTunePlayingVM().suffleTune(!switchEnabled.value);
    switchEnabled.value = !switchEnabled.value;
    print("result ========= ${result}");
    print("Result ${result}");
  }
}
