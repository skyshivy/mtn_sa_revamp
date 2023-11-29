import 'dart:math';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/home_reco_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/add_to_wishist_vm.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class RecoController extends GetxController {
  RxList<String> tabTitle = <String>[].obs;
  List<String> tabValue = [];
  List<String> tabId = [];
  RxInt selectedIndex = 0.obs;
  //RxInt items = 2.obs;
  RxList<String> featureCatList = <String>[].obs;
  List<bool> isLoadedList = <bool>[].obs;
  List<List<TuneInfo>?> tuneList = <List<TuneInfo>?>[].obs;
  RxList<TuneInfo>? displayList = <TuneInfo>[].obs;
  RxBool isLoading = false.obs;

  getTabList() async {
    tabTitle.value = [];
    tabTitle.value = [];
    tuneList.clear();
    displayList?.clear();
    selectedIndex.value = 0;
    tabId = [];
    featureCatList.clear();
    isLoadedList.clear();

    isLoading.value = true;

    var _ = await ServiceCall().getSetting(settingUrl);
    var abc = StoreManager().appSetting;
    Others? others = abc?.responseMap?.settings?.others;
    var featureCatSrt = StoreManager().isEnglish
        ? others?.featuredCategoryEnglish?.attribute
        : others?.featuredCategoryBurmese?.attribute;

    if (featureCatSrt != null) {
      featureCatList.value = featureCatSrt.split("|");
      for (String item in featureCatList) {
        tabTitle.add(item.split(",")[0]);
        tabValue.add(item.split(",")[1]);
        tabId.add(item.split(",")[2]);
        tuneList.add([]);
        isLoadedList.add(false);
      }
      printCustom(
          "Tune empty list ${tuneList.length} and item inside is ${tuneList[0]?.length}");
      getTabItems(tabValue[0], 0);
    }
  }

  updateSelectedIndex(int index) {
    selectedIndex.value = index;
    getTabItems(tabValue[index], index);
  }

  getTabItems(String identifier, int index) async {
    if (isLoadedList[index]) {
      displayList?.value = tuneList[index]!;
      printCustom("Tune na e is ${displayList?[0].toneName}");
      return;
    }
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    isLoading.value = true;
    var trailUrl =
        "language=${StoreManager().language}&msisdn=${StoreManager().msisdn}&clientTxnId=$randomNumber&identifier=$identifier";
    var result = await ServiceCall().get(recomurl + trailUrl);
    isLoading.value = false;
    if (result != null) {
      isLoadedList[index] = true;
      HomeRecomModel model = HomeRecomModel.fromJson(result);
      var tuneInfo = model.responseMap?.recommendationSongsList;
      tuneList[index] = tuneInfo;
      displayList?.value = tuneInfo!;
    }
  }

  updatePlaying(int index) {
    displayList?[index].isPlaying = displayList![index].isPlaying;
    displayList?.refresh();
  }

  wishlistTapped(TuneInfo? info) async {
    await AddToWishlistVm().add(info);
    printCustom("Wishlist tapped in tune cell");
  }

  tellAFriendTapped() {
    printCustom("Tell a friend tapped in tune cell");
  }

  shareTapped() {
    printCustom("Share tapped in tune cell");
  }
}
