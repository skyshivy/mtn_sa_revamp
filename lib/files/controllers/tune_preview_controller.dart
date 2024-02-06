import 'package:get/get.dart';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/add_to_wishist_vm.dart';
import 'package:mtn_sa_revamp/main.dart';

class TunePreviewController extends GetxController {
  RxInt index = 0.obs;
  RxBool isPlaying = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;
  RxBool hideNext = false.obs;
  RxBool hidePrevious = false.obs;
  RxBool isLoading = true.obs;
  RxBool isAddingWishlist = false.obs;
  int current = 0;
  int maxDuration = 0;
  String maxDurationStr = '00:00';
  String currentSeekingStr = '00:00';
  customInit(List<TuneInfo> list, int index) async {
    isPlaying.value = false;
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

  addToWishlistAction(TuneInfo info) async {
    isAddingWishlist.value = true;
    printCustom("Add to wishlist calledd");
    bool _ = await AddToWishlistVm().add(info);
    printCustom("Add to wishlist calledd1234");
    isAddingWishlist.value = false;
  }

  playTapped() {
    isPlaying.value = !isPlaying.value;
    playerController.playUrl(list[index.value], index.value);
    printCustom("tapped ======= ${isPlaying.value}");
  }

  prevousTapped() {
    isPlaying.value = false;
    if (index.value > 0) {
      index.value -= 1;
      hideNext.value = false;
    }
    if (index.value <= 0) {
      hidePrevious.value = true;
    }
    playTapped();
  }

  stopPlayer() {
    isPlaying.value = false;
    playerController.stop();
  }

  nextTapped() {
    isPlaying.value = false;
    if (index.value <= (list.length - 1)) {
      index.value += 1;
      hidePrevious.value = false;
    }
    if (index.value >= (list.length - 1)) {
      hideNext.value = true;
    }
    playTapped();
    printCustom("nextTapped list.length = ${list.length} =========$index");
  }
}
