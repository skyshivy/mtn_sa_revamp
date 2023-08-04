import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class FaqController extends GetxController {
  getFaqList() async {
    var res = await ServiceCall().get(faqUrl);
    print("Faq is ========== ${res}");
  }
}
