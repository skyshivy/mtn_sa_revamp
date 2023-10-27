import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

import '../../store_manager/store_manager.dart';

class SearchTuneController extends GetxController {
  RxString searchedText = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  bool _NoMoreDataToLoad = false;
  RxBool isLoadMore = false.obs;
  RxInt isTuneSelected = 0.obs;
  RxList<TuneInfo> toneList = <TuneInfo>[].obs;
  RxList<TuneInfo> songList = <TuneInfo>[].obs;
  RxList<ArtistDetailList> artistList = <ArtistDetailList>[].obs;

  clearSearchData() {
    toneList.value = [];
    songList.value = [];
    artistList.value = [];
  }

  getSearchedResult(String searchedTxt, int p,
      {bool isloadMore = false}) async {
    searchedText.value = searchedTxt;

    if (!isloadMore) {
      // toneList.clear();
      // songList.clear();
      // artistList.clear();
    }

    if (isNumericUsingRegularExpression(searchedTxt)) {
      _getSearchResultByTuneId(searchedTxt);

      return;
    }

    String s = searchedTxt.trim();
    if (s != null) {
      s = s.replaceAll(' ', '+');
    }
    if (!isloadMore) {
      isLoading.value = true;
      isLoaded.value = false;
    } else {
      isLoadMore.value = true;
    }

    var url =
        '$searchSpecificToneUrl=${StoreManager().language}&sortBy=Order_By&perPageCount=20&searchLanguage=${StoreManager().language}&searchKey=$s&pageNo=$p';
    Map<String, dynamic>? result = await ServiceCall().get(url);

    if (result != null) {
      SearchTuneModel model = SearchTuneModel.fromJson(result);
      if ((model.responseMap?.songList ?? []).isEmpty) {
        _NoMoreDataToLoad = true;
      } else {
        _NoMoreDataToLoad = false;
      }
      toneList.value += model.responseMap?.toneList ?? [];
      songList.value += model.responseMap?.songList ?? [];
      artistList.value += model.responseMap?.countList?.artistDetailList ?? [];
      print(
          "Tune list length is ${toneList.length} Tune list length ${songList.length}");
    }
    ;
    isLoading.value = false;
    isLoaded.value = true;
    isLoadMore.value = false;
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  _getSearchResultByTuneId(String tuneId) async {
    print("Tune is searched $tuneId");
    String s = tuneId.trim();
    if (s != null) {
      s = s.replaceAll(' ', '+');
    }
    // isLoading = true;
    // notifyListeners();
    // var result = await SearchVM.searchTunesById(tuneId);
    // print("search result by tune id is ${result}");
    // recomList = await Convertmodel().toneInfoModelToRecomended(
    //     result.responseMap?.searchList ?? result.responseMap?.searchList);

    // artistList = <ArtistDetailList>[];
    // isLoading = false;
    // notifyListeners();
  }

  loadMoreData() async {
    if (_NoMoreDataToLoad) {
      return;
    }
    if (isLoadMore.value) {
      return;
    }
    isLoadMore.value = true;
    getSearchedResult(searchedText.value, toneList.length, isloadMore: true);
    print("load more data search");
  }
}
