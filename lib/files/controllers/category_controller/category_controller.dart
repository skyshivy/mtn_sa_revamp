import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/category_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class CategoryController extends GetxController {
  String key = '';
  String id = '';
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
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
    resetValue();
    key = searchKey;
    id = catId;
    if (!isLoadMoreData) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }

    var url =
        "$getCategoryDetailUrl&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=English&perPageCount=$pagePerCount";

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
      searchList += list;
    }
    if (searchList.length < pagePerCount) {
      isHideLoadMore.value = true;
    }
    printCustom("Rsult is ============ $result");
  }

  loadMoreData() async {
    await getCategroyDetail(key, id,
        page: searchList.length, isLoadMoreData: true);
  }
}
