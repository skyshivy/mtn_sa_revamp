import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class AppController extends GetxController {
  RxBool isLoggedIn = false.obs;
  settinApiCall() async {
    print("Setting api calling");
    var abc = await ServiceCall().getSetting(settingUrl);

    print("=======================${abc}");
  }
}
