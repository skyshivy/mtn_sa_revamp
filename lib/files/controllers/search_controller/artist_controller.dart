import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/artist_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class ArtistController extends GetxController {
  RxBool isLaoding = false.obs;
  RxBool isLoadMore = false.obs;
  String searchedArtist = '';
  RxList<TuneInfo> searchList = <TuneInfo>[].obs;

  getArtistSongs(String artist, {int page = 0, bool isLoadMore = false}) async {
    searchList.clear();
    searchedArtist = artist;
    if (!isLoadMore) {
      isLaoding.value = true;
    }
    this.isLoadMore.value = true;
    var url =
        "$getArtistSearchTuneUrl${StoreManager().language}&artistKey=$artist&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=${StoreManager().language}&perPageCount=$pagePerCount";
    Map<String, dynamic>? res = await ServiceCall().get(url);

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
    printCustom('Artist songs list ==== ${res}');

    isLaoding.value = false;
    this.isLoadMore.value = false;
  }

  loadMoreData() {
    getArtistSongs(searchedArtist, page: searchList.length, isLoadMore: true);
    printCustom("Load more data tapped");
  }
}
