import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';

class CategoryPoupupController extends GetxController {
  RxList<AppCategory> catList = <AppCategory>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getCatList();
    super.onInit();
  }

  getCatList() async {
    isLoading.value = true;
    printCustom("making category api call");

    var result = await ServiceCall()
        .get('$categoryListUrl1?language=${StoreManager().language}');
    isLoading.value = false;
    if (result != null) {
      CategoryModel model = CategoryModel.fromJson(result);
      catList.value = model.responseMap?.categories ?? [];
    }
  }
}
