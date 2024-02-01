import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/banner_detail_manual_model.dart';
import 'package:mtn_sa_revamp/files/model/banner_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/get_banner_detail_manual_vm.dart';

class BannerDetailController extends GetxController {
  RxBool isloading = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;

  getDetail(String type, String bannerOrder, String searchKey,
      {int page = 0}) async {
    isloading.value = true;

    printCustom(
        "Called banner detail api type is = $type promoCode = $bannerOrder searchKey =$searchKey");

    String url = '';
    Map<String, dynamic>? res;
    if ((type == "Manual") || type == "manual") {
      url = bannerDetailManualUrl;
      BannerDetailManualModel mode =
          await getBannerDetailManualApiCall(bannerOrder, type);
      list.value = mode.responseMap?.bannerDetailsList ?? [];
    } else {
      url =
          "$bannerDetailUrl?language=${StoreManager().language}&pageNo=$page&pagePerCount=$pagePerCount&type=$type&searchKey=$searchKey";
      res = await ServiceCall().get(url);
    }

    if (res != null) {
      BannerDetailModel model = BannerDetailModel.fromJson(res);
      List<TuneInfo> lst = model.responseMap?.searchList ?? [];
      list.value = lst;
    }

    isloading.value = false;
  }
}
