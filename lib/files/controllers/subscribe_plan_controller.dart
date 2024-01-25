import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

class SubscribePlanController extends GetxController {
  RxList<String> packList = <String>[].obs;
  RxList<String> packChargeList = <String>[].obs;
  RxList<String> displayList = <String>[].obs;
  RxInt selectedIndex = 0.obs;
  RxBool enableSubmitButton = false.obs;
  RxString tuneCharge = ''.obs;
  String _tuneCharge = '';
  @override
  void onInit() {
    printCustom("init SubscribePlanController");
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
    _tuneCharge = others?.tonePrice?.attribute ?? '';
    super.onInit();
  }

  updateSelectedIndex(int index) {
    selectedIndex.value = index;
    enableSubmitButton.value = true;
  }

  createPackList(String str) {
    var lst = str.split('|');
    printCustom("Length is ${lst.length}");
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
      printCustom("packname ${element.split(',')[0]}");
      printCustom("display name ${element.split(',')[1]}");
    }
    // packListTemp.add('EAUC');
    // displayListTemp.add('EAUC');
    // packChargeListTemp.add("0");
    packList.value = packListTemp;
    displayList.value = displayListTemp;

    // displayList.add("EAUC");
    // packList.add("EAUC");
    packChargeList.value = packChargeListTemp;
  }

  @override
  void onClose() {
    printCustom("onClose SubscribePlanController");
    super.onClose();
  }
}
