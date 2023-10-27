import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/category_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class CategoryController extends GetxController {
  String key = '';
  String id = '';
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  bool _LoadingMore = false;
  RxBool isHideLoadMore = true.obs;
  RxList<TuneInfo> searchList = <TuneInfo>[].obs;

  resetValue() async {
    key = '';
    id = '';
    isLoadMore.value = false;
    isHideLoadMore.value = true;
    isLoading.value = false;
    searchList.value = [];
  }

  getCategroyDetail(String searchKey, String catId,
      {int page = 0, bool isLoadMoreData = false}) async {
    if (key != searchKey) {
      resetValue();
    }
    //
    key = searchKey;
    id = catId;
    if (isLoadMoreData) {
      isLoadMore.value = true;
    } else {
      isLoading.value = true;
    }
    //isLoading.value = true;
    _LoadingMore = true;
    var url =
        "$getCategoryDetailUrl&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=English&perPageCount=$perPageCount";

    Map<String, dynamic>? result = await ServiceCall().get(url);
    isLoading.value = false;
    isLoadMore.value = false;
    if (result != null) {
      CategoryDetailModel categoryDetailModel =
          CategoryDetailModel.fromJson(result);
      var list = categoryDetailModel.responseMap?.searchList ?? [];
      if (list.isEmpty) {
        isHideLoadMore.value = true;
      }

      print("New items length = ${list.length}");
      print("Old total  items length = ${searchList.length}");
      searchList += list;
      print("New total  items length = ${searchList.length}");
      if (list.isEmpty) {
        isHideLoadMore.value = true;
      }
      _LoadingMore = false;
    }
    if (searchList.length < perPageCount) {
      isHideLoadMore.value = true;
    }
    print("Rsult is ============ $result");
  }

  loadMoreData() async {
    if (_LoadingMore) {
      return;
    }
    isLoadMore.value = true;
    await getCategroyDetail(key, id,
        page: searchList.length, isLoadMoreData: true);
  }
}
