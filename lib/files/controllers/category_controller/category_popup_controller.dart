import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';

class CategoryPoupupController extends GetxController {
  RxList<Category> catList = <Category>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getCatList();
    super.onInit();
  }

  getCatList() async {
    isLoading.value = true;
    var result = await ServiceCall().get(categoryListUrl);
    isLoading.value = false;
    if (result != null) {
      CategoryModel model = CategoryModel.fromJson(result);
      catList.value = model.responseMap?.categories ?? [];
    }
  }
}
