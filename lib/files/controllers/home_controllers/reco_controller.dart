import 'dart:math';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/home_reco_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/add_to_wishist_vm.dart';

class RecoController extends GetxController {
  List<String> tabTitle = [];
  List<String> tabValue = [];
  List<String> tabId = [];
  RxInt selectedIndex = 0.obs;
  RxInt items = 2.obs;
  RxList<String> featureCatList = <String>[].obs;
  List<bool> isLoadedList = <bool>[].obs;
  List<List<TuneInfo>?> tuneList = <List<TuneInfo>?>[].obs;
  RxList<TuneInfo>? displayList = <TuneInfo>[].obs;
  RxBool isLoading = false.obs;

  getTabList() async {
    return;
    var abc = StoreManager().appSetting;
    var featureCatSrt =
        abc.responseMap?.settings?.others?.featuredCategoryEnglish?.attribute;
    if (featureCatSrt != null) {
      featureCatList.value = featureCatSrt.split("|");
      for (String item in featureCatList) {
        tabTitle.add(item.split(",")[0]);
        tabValue.add(item.split(",")[1]);
        tabId.add(item.split(",")[2]);
        tuneList.add([]);
        isLoadedList.add(false);
      }
      print(
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
      print("Tune na e is ${displayList?[0].toneName}");
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

  wishlistTapped(TuneInfo? info) {
    AddToWishlistVm().add(info);
    print("Wishlist tapped in tune cell");
  }

  tellAFriendTapped() {
    print("Tell a friend tapped in tune cell");
  }

  shareTapped() {
    print("Share tapped in tune cell");
  }
}
