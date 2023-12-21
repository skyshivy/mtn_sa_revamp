import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/category_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/search_toneid_model.dart';
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
  RxBool isLoadingArtist = false.obs;
  RxBool isLoadingCode = false.obs;
  RxBool isLoaded = false.obs;
  RxInt searchType = 0.obs;

  RxBool isLoadMore = false.obs;
  RxInt isTuneSelected = 0.obs;
  RxList<TuneInfo> toneList = <TuneInfo>[].obs;
  RxList<TuneInfo> songList = <TuneInfo>[].obs;
  RxList<ArtistDetailList> artistList = <ArtistDetailList>[].obs;
  bool stopMultipleApiCall = true;
  getSearchedResult(String searchedTxt, int p,
      {bool isloadMore = false, int? searchTypeIndex}) async {
    if (!stopMultipleApiCall) {
      await Future.delayed(Duration(milliseconds: 300));
      stopMultipleApiCall = true;
      return;
    }
    stopMultipleApiCall = false;
    if (searchTypeIndex != null) {
      searchType.value = searchTypeIndex;
    }
    searchedText.value = searchedTxt;
    if (searchType.value == 3) {
      print("name tune search here");
      _searchNameTune(searchedTxt);
      return;
    } else if (searchType.value == 2) {
      print("Search Tune code here");
      _getSearchResultByTuneId(searchedTxt);
      return;
    } else if (searchType.value == 1) {
      print("Search Singer list here");
      isLoadingArtist.value = true;
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

    isLoading.value = false;
    isLoaded.value = true;
    isLoadMore.value = false;
    isLoadingArtist.value = false;
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

    toneList.value = [];
    songList.value = [];
    artistList.value = [];

    String s = tuneId.trim();
    if (s != null) {
      s = s.replaceAll(' ', '+');
    }
    isLoading.value = true;
    isLoadingCode.value = true;
    //await Future.delayed(Duration(seconds: 3));
    SearchToneidModel mode = await searchToneIdApi(tuneId);
    isLoading.value = false;
    isLoaded.value = true;
    if (mode.statusCode == "SC0000") {
      toneList.value = mode.responseMap?.toneList ?? [];
      songList.value = mode.responseMap?.songList ?? [];
    } else {
      toneList.value = [];
      songList.value = [];
    }

    isLoadingCode.value = false;
  }

  loadMoreData() async {
    if (searchType.value == 3) {
      print("name tune search here");
      _searchNameTune(searchedText.value, isloadMore: true);
      return;
    }
    getSearchedResult(searchedText.value, toneList.length, isloadMore: true);
    printCustom("load more data search");
  }

  _searchNameTune(String searchKey, {bool isloadMore = false}) async {
    if (!isloadMore) {
      toneList.clear();
      songList.clear();
      artistList.clear();
    }
    isLoadMore.value = isloadMore;
    searchedText.value = searchKey;
    Others? others = StoreManager().appSetting?.responseMap?.settings?.others;
    String catId = others?.nameTuneCategoryid?.attribute ?? '0';
    if (!isloadMore) {
      isLoading.value = true;
    }

    isLoaded.value = false;
    var url =
        "$nameTuneSearchUrl?language=${StoreManager().language}&categoryId=$catId&pageNo=${songList.length}&perPageCount=$pagePerCount&searchLanguage=${StoreManager().language}";

    //"$getCategoryDetailUrl&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=${songList.length}&searchLanguage=English&perPageCount=$pagePerCount";
    Map<String, dynamic>? result =
        await ServiceCall().get(url, params: {'Searchkey': searchKey});
    print("result is $result");
    if (result != null) {
      SearchTuneModel model = SearchTuneModel.fromJson(result);
      print("list length is  ${model.responseMap?.songList?.length}");

      songList.value +=
          model.responseMap?.songList ?? model.responseMap?.toneList ?? [];
    }
    isLoading.value = false;
    isLoaded.value = true;
    isLoadMore.value = false;
  }
}
