import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

class RecoController extends GetxController {
  List<String> tabTitle = [];
  List<String> tabValue = [];
  List<String> tabId = [];
  RxInt selectedIndex = 0.obs;
  RxInt items = 2.obs;
  RxList<String> featureCatList = <String>[].obs;
  getTabList() async {
    var abc = StoreManager().appSetting;
    var featureCatSrt =
        abc.responseMap?.settings?.others?.featuredCategoryEnglish?.attribute;
    if (featureCatSrt != null) {
      featureCatList.value = featureCatSrt.split("|");
      for (String item in featureCatList) {
        tabTitle.add(item.split(",")[0]);
        tabValue.add(item.split(",")[1]);
        tabId.add(item.split(",")[2]);
      }
    }
  }

  updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
