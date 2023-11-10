import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class SettingController extends GetxController {
  RxList list = [
    profileStr,
    myTuneStr,
    wishlistStr,
    historyStr,
    faqStr.tr,
    enarStr,
    logoutStr,
  ].obs;
}
