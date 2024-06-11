import 'package:get/get.dart';

import 'package:get/state_manager.dart';
import 'package:mtn_sa_revamp/files/custom_files/chunks.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/normal_tune_search_model.dart';
import 'package:mtn_sa_revamp/files/model/search_toneid_model.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_artist_api.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_name_tune_api.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_tone_id_api.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_tune_api.dart';

enum SearchType { toneSearch, artistSearch, toneIdSearch, nameToneSearch }

class NewSearchController extends GetxController {
  String searchedText = '';
  RxBool hideNextButton = false.obs;
  RxBool hidePreviousButton = true.obs;
  RxBool hideMoreButtons = true.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 0.obs;
  RxInt totalCount = 0.obs;
  int totalPage = 1;

  List<TuneInfo> _toneList = <TuneInfo>[];
  RxList<ArtistDetailList?> artistList = <ArtistDetailList>[].obs;
  final RxList<TuneInfo> displayList = <TuneInfo>[].obs;

  reset() {
    totalCount.value = 0;
    hideNextButton.value = false;
    hidePreviousButton.value = false;
    isLoadingMore.value = false;
    currentPage.value = 0;
    totalPage = 1;
    artistList.clear();
    _toneList.clear();
    displayList.clear();
  }

  updateSearchedText(String text) {
    searchedText = text;
  }

  Rx<SearchType> searchType = SearchType.toneSearch.obs;

  getSearchedResult(SearchType searchType) {
    hideMoreButtons.value = true;
    reset();
    this.searchType.value = searchType;
    printCustom("Searching text ===  $searchedText");
    switch (searchType) {
      case SearchType.toneSearch:
        _getTuneList();
        break;
      case SearchType.artistSearch:
        _getArtistList();
        break;
      case SearchType.toneIdSearch:
        _getTuneIdList();
        break;
      case SearchType.nameToneSearch:
        _getNameTuneList();
        break;
      default:
        _getTuneList();
    }
  }

  // =========== Get tone ==========

  _getTuneList() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    printCustom("_getTuneList");
    AdvanceSearchModel model = await searchTuneApi(searchedText);
    _toneList = model.responseMap?.toneList ?? [];
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hideNextButton.value = false;
    }
    _createChunks();
    isLoading.value = false;
  }

// =========== Get name tune search ==========
  _getNameTuneList() async {
    printCustom("_getNameTuneList");
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    printCustom("_getTuneList");
    SearchTuneModel model = await nameTuneSearchApi(searchedText);
    _toneList = model.responseMap?.toneList ?? [];
    totalCount.value = model.responseMap?.toneTotalCount ?? 0;
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = true;
    }
    _createChunks();
    isLoading.value = false;
  }
  // ========== Search tone id ====================
  //searchToneIdApi

  _getTuneIdList() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchToneidModel model = await searchToneIdApi(searchedText);
    _toneList = model.responseMap?.songList ?? [];
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = true;
    }
    displayList.value = _toneList;
    isLoading.value = false;
    printCustom("_getTuneIdList");
  }

  // ========= search artist ============

  _getArtistList() async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    SearchTuneModel model = await searchArtistApi(searchedText);
    artistList.value = (model.responseMap?.countList?.artistDetailList ?? []);
    hideMoreButtons.value = artistList.length < pagePerCount;
    totalCount.value = model.responseMap?.toneTotalCount ?? 0;
    if ((model.responseMap?.countList?.artistDetailList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hidePreviousButton.value = true;
      hideNextButton.value = false;
    }
    printCustom("_getArtistList");
    isLoading.value = false;
  }

  // ============ Load more, create chunk,next and previous section ===============

  _createChunks() async {
    print("Current page = $currentPage");
    ChunksModel chunksModel =
        await createChunksOfSize(_toneList, displayIndex: currentPage.value);

    hideMoreButtons.value = _toneList.length < pagePerCount;

    displayList.value = chunksModel.list;
    totalPage = chunksModel.pages;
  }

  loadMoreData() async {
    isLoadingMore.value = true;
    if (searchType.value == SearchType.artistSearch) {
      await _loadMoreArtists();
    } else if (searchType.value == SearchType.toneIdSearch) {
    } else if (searchType.value == SearchType.nameToneSearch) {
      await _loadMoreNameTunes();
    } else {
      await _loadMoreTunes();
    }
    isLoadingMore.value = false;
  }

  nextButtonAction() async {
    if (hideNextButton.value) {
      return;
    }
    if (isLoadingMore.value) {
      return;
    }
    currentPage.value += 1;
    hidePreviousButton.value = false;
    print("next button totalPage = $totalPage and currentPage $currentPage");
    if ((totalPage) > currentPage.value) {
      _createChunks();
      hidePreviousButton.value = currentPage.value == 0;
    } else {
      loadMoreData();
    }
  }

  previousButtonAction() async {
    if (hidePreviousButton.value) {
      return;
    }
    if (currentPage.value == 0) {
      hidePreviousButton.value = true;
      return;
    }
    hideNextButton.value = false;
    currentPage -= 1;

    if (totalPage > currentPage.value) {
      ChunksModel mo =
          await createChunksOfSize(_toneList, displayIndex: currentPage.value);
      totalPage = mo.pages;
      displayList.value = mo.list;

      hidePreviousButton.value = currentPage.value == 0;
    }
  }

  Future<void> _loadMoreTunes() async {
    AdvanceSearchModel model =
        await searchTuneApi(searchedText, pageNo: _toneList.length);
    _toneList += model.responseMap?.toneList ?? [];
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = false;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = false;
    }

    _createChunks();
    return;
  }

  Future<void> _loadMoreNameTunes() async {
    SearchTuneModel model =
        await nameTuneSearchApi(searchedText, pageNo: _toneList.length);
    _toneList += model.responseMap?.toneList ?? [];

    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = false;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = false;
    }

    _createChunks();
    return;
  }

  Future<void> _loadMoreArtists() async {
    isLoadingMore.value = true;
    SearchTuneModel model = await searchArtistApi(searchedText);
    List<ArtistDetailList?> lst =
        (model.responseMap?.countList?.artistDetailList ?? []);
    hideMoreButtons.value = lst.length < pagePerCount;
    if ((model.responseMap?.countList?.artistDetailList ?? []).length <
        pagePerCount) {
      hideNextButton.value = true;
      hidePreviousButton.value = false;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = false;
    }
    artistList.value += lst;
    return;
  }

  //==================== Load page wise===================
  loadOnPageNumberData({int pageNo = 0}) async {
    if (searchType.value == SearchType.artistSearch) {
      await _loadArtistsOnPage(pageNo * pagePerCount);
    } else if (searchType.value == SearchType.toneIdSearch) {
    } else if (searchType.value == SearchType.nameToneSearch) {
      await _loadNameTunesOnPage(pageNo * pagePerCount);
    } else {
      await _loadTunesOnPage(pageNo * pagePerCount);
    }
  }

  _loadArtistsOnPage(int pageNo) async {
    isLoading.value = true;
    SearchTuneModel model = await searchArtistApi(searchedText, pageNo: pageNo);
    artistList.value = (model.responseMap?.countList?.artistDetailList ?? []);
    isLoading.value = false;
  }

  _loadNameTunesOnPage(int pageNo) async {
    isLoading.value = true;
    SearchTuneModel model =
        await nameTuneSearchApi(searchedText, pageNo: pageNo);
    displayList.value = model.responseMap?.toneList ?? [];
    isLoading.value = false;
  }

  _loadTunesOnPage(int pageNo) async {
    isLoading.value = true;
    AdvanceSearchModel model =
        await searchTuneApi(searchedText, pageNo: pageNo);
    displayList.value = model.responseMap?.toneList ?? [];
    isLoading.value = false;
  }
}
