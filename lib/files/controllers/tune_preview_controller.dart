import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

class TunePreviewController extends GetxController {
  RxInt index = 0.obs;
  RxBool isPlaying = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;
  RxBool hideNext = false.obs;
  RxBool hidePrevious = false.obs;
  RxBool isLoading = true.obs;

  customInit(List<TuneInfo> list, int index) async {
    this.list.value = list;
    this.index.value = index;
    isLoading.value = false;

    if (list.length < 2) {
    } else {
      hideNext.value = false;
      hidePrevious.value = false;
    }
    if (index == 0) {
      hidePrevious.value = true;
    }
    if (index == (list.length - 1)) {
      hideNext.value = true;
    }
  }

  playTapped() {
    isPlaying.value = !isPlaying.value;
    print("tapped ======= ${isPlaying.value}");
  }

  prevousTapped() {
    isPlaying.value = false;
    if (index.value > 0) {
      index.value -= 1;
    }
  }

  nextTapped() {
    isPlaying.value = false;
    if (index.value <= (list.length - 1)) {
      index.value += 1;
    }
  }
}
