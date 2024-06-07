import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/chunks.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/normal_tune_search_model.dart';
import 'package:mtn_sa_revamp/files/model/search_toneid_model.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_name_tune_api.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_tone_id_api.dart';
import 'package:mtn_sa_revamp/files/view_model/search_apis/search_tune_api.dart';

enum SearchType { toneSearch, artistSearch, toneIdSearch, nameToneSearch }

class NewSearchController extends GetxController {
  String searchedText = '';
  RxBool hideNextButton = false.obs;
  RxBool hidePreviousButton = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool isLoading = false.obs;
  RxInt currentPage = 0.obs;
  int totalPage = 1;

  List<TuneInfo> _toneList = <TuneInfo>[];
  final RxList<TuneInfo> displayList = <TuneInfo>[].obs;

  reset() {
    hideNextButton.value = false;
    hidePreviousButton.value = false;
    isLoadingMore.value = false;
    currentPage.value = 0;
    totalPage = 1;

    _toneList.clear();
    displayList.clear();
  }

  updateSearchedText(String text) {
    searchedText = text;
  }

  Rx<SearchType> searchType = SearchType.toneSearch.obs;

  getSearchedResult(SearchType searchType) {
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

  _getArtistList() async {
    printCustom("_getArtistList");
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
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
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
    _toneList = model.responseMap?.toneList ?? [];

    isLoading.value = false;
    printCustom("_getTuneIdList");
  }

  // ============ Load more, create chunk,next and previous section ===============

  _createChunks() async {
    print("Current page = $currentPage");
    ChunksModel chunksModel =
        await createChunksOfSize(_toneList, displayIndex: currentPage.value);
    displayList.value = chunksModel.list;
    totalPage = chunksModel.pages;
  }

  loadMoreData() async {
    isLoadingMore.value = true;
    if (searchType.value == SearchType.artistSearch) {
    } else if (searchType.value == SearchType.toneIdSearch) {
    } else if (searchType.value == SearchType.nameToneSearch) {
      _loadMoreNameTunes();
    } else {
      await _loadMoreTunes();
    }
    isLoadingMore.value = false;
  }

  nextButtonAction() async {
    currentPage.value += 1;
    print("next button totalPage = $totalPage and currentPage $currentPage");
    if ((totalPage) > currentPage.value) {
      _createChunks();
      hidePreviousButton.value = currentPage.value == 0;
    } else {
      loadMoreData();
    }
  }

  previousButtonAction() async {
    if (currentPage.value == 0) {
      return;
    }
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
    isLoadingMore.value = true;

    AdvanceSearchModel model =
        await searchTuneApi(searchedText, pageNo: _toneList.length);
    _toneList += model.responseMap?.toneList ?? [];
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = false;
    }

    _createChunks();
    isLoadingMore.value = false;
  }

  Future<void> _loadMoreNameTunes() async {
    isLoadingMore.value = true;

    SearchTuneModel model =
        await nameTuneSearchApi(searchedText, pageNo: _toneList.length);
    _toneList += model.responseMap?.toneList ?? [];
    if ((model.responseMap?.toneList ?? []).isEmpty) {
      hideNextButton.value = true;
      hidePreviousButton.value = true;
    } else {
      hideNextButton.value = false;
      hidePreviousButton.value = false;
    }

    _createChunks();
    isLoadingMore.value = false;
  }
}
