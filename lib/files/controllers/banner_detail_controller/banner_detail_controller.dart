import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/banner_detail_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class BannerDetailController extends GetxController {
  RxBool isloading = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;

  getDetail(String promoCode, String searchKey, {int page = 0}) async {
    isloading.value = true;

    String url =
        "$bannerDetailUrl&pageNo=$page&pagePerCount=$pagePerCount&type=$promoCode&searchKey=$searchKey";
    Map<String, dynamic>? res = await ServiceCall().get(url);
    if (res != null) {
      BannerDetailModel model = BannerDetailModel.fromJson(res);
      List<TuneInfo> lst = model.responseMap?.searchList ?? [];
      list.value = lst;
    }

    isloading.value = false;
  }
}
