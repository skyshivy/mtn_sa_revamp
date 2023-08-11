import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/faq_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class FaqController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<FaqList> list = <FaqList>[].obs;
  getFaqList() async {
    isLoading.value = true;
    Map<String, dynamic>? res = await ServiceCall().get(faqUrl);
    isLoading.value = true;
    if (res != null) {
      FaqModel faqModel = FaqModel.fromJson(res);
      var lst = faqModel.faqList ?? [];
      list.value = lst;
    }
    isLoading.value = false;
  }

  cellTapped(int index) {
    list[index].isOpen!.value = !list[index].isOpen!.value;
  }
}
