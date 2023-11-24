import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/search_tone_id_api.dart';
import 'package:mtn_sa_revamp/main.dart';

import '../../store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class SearchTuneController extends GetxController {
  RxString searchedText = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxInt searchType = 0.obs;

  RxBool isLoadMore = false.obs;
  RxInt isTuneSelected = 0.obs;
  RxList<TuneInfo> toneList = <TuneInfo>[].obs;
  RxList<TuneInfo> songList = <TuneInfo>[].obs;
  RxList<ArtistDetailList> artistList = <ArtistDetailList>[].obs;

  getSearchedResult(String searchedTxt, int p,
      {bool isloadMore = false}) async {
    searchedText.value = searchedTxt;
    if (searchType.value == 2) {
      print("Search Tune code here");
      _getSearchResultByTuneId(searchedTxt);
      return;
    } else if (searchType.value == 1) {
      print("Search Singer list here");
      return;
    } else {
      print("Search narmal tune herr");
    }

    keyScrollFocusNode.requestFocus();
    if (!isloadMore) {
      toneList.clear();
      songList.clear();
      artistList.clear();
    }

    // if (isNumericUsingRegularExpression(searchedTxt)) {
    //   _getSearchResultByTuneId(searchedTxt);

    //   return;
    // }

    String s = searchedTxt.trim();
    if (s != null) {
      s = s.replaceAll(' ', '+');
    }
    if (!isloadMore) {
      isLoading.value = true;
      isLoaded.value = false;
    }
    isLoadMore.value = true;
    var url =
        '$searchSpecificToneUrl=${StoreManager().language}&sortBy=Order_By&perPageCount=$pagePerCount&searchLanguage=${StoreManager().language}&searchKey=$s&pageNo=$p';
    Map<String, dynamic>? result = await ServiceCall().get(url);

    if (result != null) {
      SearchTuneModel model = SearchTuneModel.fromJson(result);
      toneList.value += model.responseMap?.toneList ?? [];
      songList.value += model.responseMap?.songList ?? [];
      artistList.value += model.responseMap?.countList?.artistDetailList ?? [];
      printCustom(
          "Tune list length is ${toneList.length} Tune list length ${songList.length}");
    }
    ;
    isLoading.value = false;
    isLoaded.value = true;
    isLoadMore.value = false;
  }

  updateSearchType(int index) {
    searchType.value = index;
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  _getSearchResultByTuneId(String tuneId) async {
    printCustom("Tune is id $tuneId");
    String s = tuneId.trim();
    if (s != null) {
      s = s.replaceAll(' ', '+');
    }
    isLoading.value = true;

    await searchToneIdApi(tuneId);
    // var result = await SearchVM.searchTunesById(tuneId);
    // customPrint("search result by tune id is ${result}");
    // recomList = await Convertmodel().toneInfoModelToRecomended(
    //     result.responseMap?.searchList ?? result.responseMap?.searchList);

    artistList.value = <ArtistDetailList>[];
    isLoading.value = false;
  }

  loadMoreData() async {
    getSearchedResult(searchedText.value, toneList.length, isloadMore: true);
    printCustom("load more data search");
  }
}
