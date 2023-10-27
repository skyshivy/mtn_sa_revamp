import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/artist_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class ArtistController extends GetxController {
  RxBool isLaoding = false.obs;
  RxBool isLoadMore = false.obs;
  String searchedArtist = '';
  bool _loading = false;
  RxList<TuneInfo> searchList = <TuneInfo>[].obs;

  getArtistSongs(String artist, {int page = 0, bool isLoadMore = false}) async {
    searchedArtist = artist;
    if (!isLoadMore) {
      searchList.value = [];
      isLaoding.value = true;
    }
    if (page != 0) {
      this.isLoadMore.value = true;
    }
    _loading = true;
    var url =
        "$getArtistSearchTuneUrl${StoreManager().isEnglish ? "English" : "Arabic"}&artistKey=$artist&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=${StoreManager().isEnglish ? "English" : "Arabic"}&perPageCount=20";
    Map<String, dynamic>? res = await ServiceCall().get(url);
    _loading = false;
    if (res != null) {
      ArtistModel artistModel = ArtistModel.fromJson(res);
      List<TuneInfo> list = artistModel.responseMap?.searchList ?? [];
      if (list.isEmpty) {
        showSnackBar();
        isLaoding.value = false;
        this.isLoadMore.value = false;
        return;
      }
      searchList.value += list;
    }
    print('Artist songs list ==== ${res}');

    isLaoding.value = false;
    this.isLoadMore.value = false;
  }

  loadMoreData() {
    if (_loading) {
      return;
    }
    getArtistSongs(searchedArtist, page: searchList.length, isLoadMore: true);
    print("Load more data tapped");
  }
}
