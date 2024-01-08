import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:html_unescape/html_unescape.dart';
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
  RxList<ArtistDetailList?> artistList = <ArtistDetailList>[].obs;
  bool stopMultipleApiCall = true;
  getSearchedResult(String searchedTxt, int p,
      {bool isloadMore = false, int? searchTypeIndex}) async {
    print("called getSearchedResult");

    if (!stopMultipleApiCall) {
      print("object  not searching here");
      await Future.delayed(const Duration(milliseconds: 80));
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

    String s = searchedText.value.trim();
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
      try {
        SearchTuneModel model = SearchTuneModel.fromJson(result);
        toneList.value += model.responseMap?.toneList ?? [];
        songList.value += model.responseMap?.songList ?? [];

        artistList.value +=
            (model.responseMap?.countList?.artistDetailList ?? []);
        printCustom(
            "Tune list length is ${toneList.length} Tune list length ${songList.length}");
      } catch (e) {
        print("decoding issue = $e");
      }
    } else {
      print("some thing went wrong  in search");
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

    if (!isloadMore) {
      isLoading.value = true;
    }

    isLoaded.value = false;
    if (StoreManager().appSetting == null) {
      await Future.delayed(Duration(seconds: 2));
    }
    Others? others = StoreManager().appSetting?.responseMap?.settings?.others;

    String catId = others?.nameTuneCategoryid?.attribute ?? '0';
    var url =
        "$nameTuneSearchUrl?language=${StoreManager().language}&categoryId=$catId&pageNo=${songList.length}&perPageCount=$pagePerCount&searchLanguage=${StoreManager().language}";

    //"$getCategoryDetailUrl&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=${songList.length}&searchLanguage=English&perPageCount=$pagePerCount";
    Map<String, dynamic>? result =
        await ServiceCall().get(url, params: {'searchKey': searchKey});
    print("result is $result");
    if (result != null) {
      SearchTuneModel model = SearchTuneModel.fromJson(result);
      print("list length is  ${model.responseMap?.songList?.length}");

      songList.value +=
          model.responseMap?.songList ?? model.responseMap?.toneList ?? [];
    } else {
      print("some thing went wrong  in search");
    }

    isLoading.value = false;
    isLoaded.value = true;
    isLoadMore.value = false;
  }
}
/*
const newVal = """{
   "responseMap":{
      "toneList":[
         {
            "toneId":"5665613",
            "previewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOB5xVuAWj6sbjDnrTyrnh4h5oTigfJlg01SVN8hOWyu7nLfBTKPIL/LkQqtZ5VDCiB6oo/jy5dZTOTomerh/R3w\u003d",
            "toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOB5xVuAWj6sbjDnrTyrnh4iuG1eviC6UH/WWPIugDx8B98Beu2hDeDeLiu7ac3i2ZYL0pd0pr3KK30aeSk+ZVtU\u003d",
            "toneName":"ဢမ်ႇမေႃတိူဝ်ႉၸႂ်",
            "artistName":"ပူႇပီး",
            "price":300.0,
            "categoryId":30,
            
            "expiryDate":"31/12/2025",
            "likeCount":"NULL",
            "toneIdStreamingUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003d4KMDbdHL91E\u003d",
            "toneIdpreviewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003d4KMDbdHL91E\u003d"
         }
      ],
      "songTotalCount":1,
      "toneTotalCount":1,
      "songList":[
         {
            "toneId":"5665613",
            "previewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOB5xVuAWj6sbjDnrTyrnh4h5oTigfJlg01SVN8hOWyu7nLfBTKPIL/LkQqtZ5VDCiB6oo/jy5dZTOTomerh/R3w\u003d",
            "toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOB5xVuAWj6sbjDnrTyrnh4iuG1eviC6UH/WWPIugDx8B98Beu2hDeDeLiu7ac3i2ZYL0pd0pr3KK30aeSk+ZVtU\u003d",
            "toneName":"ဢမ်ႇမေႃတိူဝ်ႉၸႂ်",
            "artistName":"ပူႇပီး",
            
            "price":300.0,
            "categoryId":30,
            "expiryDate":"31/12/2025",
            "likeCount":"NULL",
            "toneIdStreamingUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003d4KMDbdHL91E\u003d",
            "toneIdpreviewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003d4KMDbdHL91E\u003d"
         }
      ]
   },
   "message":"Success",
   "respTime":"Jan 8, 2024 5:22:53 PM",
   "statusCode":"SC0000"
} """;

var newVal1 = """{
   "responseMap":{
      
      "toneList":[
         {
          
            "toneId":"55513527",
            "previewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOCMEPdd1h3mpk2YBQhcUYAh5oTigfJlg0wUVjL0vyr3EHxDoLy3c6hhhMal4fCr3fC19QTvtKCTkflnzhX15GYwCVaj8Eq3hi9f+PgeCKRrI",
            "toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOCMEPdd1h3mpk2YBQhcUYAjeibXy+5ONy3vwQ1lw66Qu6XWpsaf+tUN/AN10YFq/vGdTb92XHqAxbYtTKefx3ODonfSgud4OEw\u003d\u003d",
            "toneName":"SHIV",
            "artistName":"Theory Khualpu",
            "albumName":"Suang Manpha Sang Manpha Zaw",
            "price":300.0,
            "categoryId":3,
            "expiryDate":"31/12/2025",
            "likeCount":"NULL",
            "toneIdStreamingUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dQAedrjZPFwHfRp5KT5lW1Q\u003d\u003d",
            "toneIdpreviewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dQAedrjZPFwHfRp5KT5lW1Q\u003d\u003d"
         }
      ],
      "songTotalCount":91,
      "toneTotalCount":91,
      "songList":[
         {
            "toneId":"55513527",
            "previewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOCMEPdd1h3mpk2YBQhcUYAh5oTigfJlg0wUVjL0vyr3EHxDoLy3c6hhhMal4fCr3fC19QTvtKCTkflnzhX15GYwCVaj8Eq3hi9f+PgeCKRrI",
            "toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOCMEPdd1h3mpk2YBQhcUYAjeibXy+5ONy3vwQ1lw66Qu6XWpsaf+tUN/AN10YFq/vGdTb92XHqAxbYtTKefx3ODonfSgud4OEw\u003d\u003d",
            "toneName":"SKumar",
            "artistName":"Theory Khualpu",
            "albumName":"Suang Manpha Sang Manpha Zaw",
            "price":300.0,
            "categoryId":3,
            "expiryDate":"31/12/2025",
            "likeCount":"NULL",
            "toneIdStreamingUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dQAedrjZPFwHfRp5KT5lW1Q\u003d\u003d",
            "toneIdpreviewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dQAedrjZPFwHfRp5KT5lW1Q\u003d\u003d"
         }
      ]
   },
   "message":"Success",
   "respTime":"Jan 8, 2024 5:20:31 PM",
   "statusCode":"SC0000"
}""";
*/