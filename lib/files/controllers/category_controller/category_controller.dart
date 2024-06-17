import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mtn_sa_revamp/files/model/category_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CategoryController extends GetxController {
  late SizingInformation si;
  String key = '';
  String id = '';
  RxInt totolCount = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;
  RxBool isHideLoadMore = true.obs;
  RxList<TuneInfo> searchList = <TuneInfo>[].obs;
  RxList<TuneInfo> displayList = <TuneInfo>[].obs;

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
    totolCount.value = 0;
    resetValue();
    key = searchKey;
    id = catId;
    getCategoryDetail1(searchKey, catId);
    return;
    if (!isLoadMoreData) {
      resetValue();
    }

    key = searchKey;
    id = catId;
    if (!isLoadMoreData) {
      isLoading.value = true;
    } else {
      isLoadMore.value = true;
    }

    var url =
        "$getCategoryDetailUrl?language=${StoreManager().language}&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=${StoreManager().language}&perPageCount=$pagePerCount";
    Map<String, dynamic>? result;
    //if (kDebugMode) {
    result = await ServiceCall().get(url);
    //result = json.decode(json1);
    // } else {
    //   result = json.decode(json1);
    // }

    isLoading.value = false;
    isLoadMore.value = false;
    isHideLoadMore.value = false;
    if (result != null) {
      CategoryDetailModel categoryDetailModel =
          CategoryDetailModel.fromJson(result);
      var list = categoryDetailModel.responseMap?.searchList ?? [];
      totolCount.value = categoryDetailModel.responseMap?.totalCount ?? 0;
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

  getCategoryDetail1(String searchKey, String catId, {int page = 0}) async {
    isLoading.value = true;
    var url =
        "$getCategoryDetailUrl?language=${StoreManager().language}&searchKey=$searchKey&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=$page&searchLanguage=${StoreManager().language}&perPageCount=$pagePerCount";
    Map<String, dynamic>? result;
    result = await ServiceCall().get(url);
    if (result != null) {
      CategoryDetailModel categoryDetailModel =
          CategoryDetailModel.fromJson(result);
      searchList.value = categoryDetailModel.responseMap?.searchList ?? [];
      totolCount.value = categoryDetailModel.responseMap?.totalCount ?? 0;
    }
    isLoading.value = false;
  }

  loadMoreOnPageNumberData(int pageNo) async {
    await getCategoryDetail1(key, id, page: pageNo);
  }
}
