import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/home_banner_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class BannerController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<HomeBanner> bannerList = <HomeBanner>[].obs;
  RxInt selectedIndex = 0.obs;
  getBanner() async {
    isLoading.value = true;
    var url = homeBannerurl + StoreManager().language;
    Map<String, dynamic>? result = await ServiceCall().get(url);
    isLoading.value = false;
    if (result != null) {
      HomeBannerModel bannerModel = HomeBannerModel.fromJson(result);
      bannerList.value = bannerModel.responseMap?.banners ?? [];
      return;
    }
    bannerList.value = [];
    //customPrint("+++++++++++++++banner detai;l is ${abc}");
  }

  updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
