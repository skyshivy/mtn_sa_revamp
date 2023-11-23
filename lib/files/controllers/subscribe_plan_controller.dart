import 'package:get/get.dart';

import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

class SubscribePlanController extends GetxController {
  RxList<String> packList = <String>[].obs;
  RxList<String> packChargeList = <String>[].obs;
  RxList<String> displayList = <String>[].obs;
  RxInt selectedIndex = 0.obs;
  RxBool enableSubmitButton = false.obs;
  RxString tuneCharge = ''.obs;
  @override
  void onInit() {
    print("init SubscribePlanController");
    selectedIndex.value = -1;
    Others? others = StoreManager()
        .appSetting
        ?.responseMap
        ?.settings
        ?.others; //.packnameEnglish
    String arra = (StoreManager().isEnglish
            ? others?.packnameEnglish?.attribute
            : others?.packnameBurmese?.attribute) ??
        '';
    createPackList(arra);
    tuneCharge.value = others?.tonePrice?.attribute ?? '';
    super.onInit();
  }

  updateSelectedIndex(int index) {
    selectedIndex.value = index;
    enableSubmitButton.value = true;
  }

  createPackList(String str) {
    var lst = str.split('|');
    print("Length is ${lst.length}");
    List<String> packListTemp = [];
    List<String> displayListTemp = [];
    List<String> packChargeListTemp = [];
    for (String element in lst) {
      try {
        packListTemp.add(element.split(',')[0]);
      } catch (e) {
        packListTemp.add('');
      }
      try {
        displayListTemp.add(element.split(',')[1]);
      } catch (e) {
        displayListTemp.add('');
      }
      try {
        packChargeListTemp.add(element.split(',')[2]);
      } catch (e) {
        packChargeListTemp.add('');
      }
      print("packname ${element.split(',')[0]}");
      print("display name ${element.split(',')[1]}");
    }
    packList.value = packListTemp;
    displayList.value = displayListTemp;
    packChargeList.value = packChargeListTemp;
  }

  @override
  void onClose() {
    print("onClose SubscribePlanController");
    super.onClose();
  }
}
