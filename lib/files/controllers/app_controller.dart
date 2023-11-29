import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class AppController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxInt index = 0.obs;
  RxBool testBool = false.obs;
  RxBool isEnglish = true.obs;
  String tunePrice = '';
  settinApiCall() async {
    printCustom("Setting api calling");
    var abc = await ServiceCall().getSetting(settingUrl);
    getTunePrice();
    printCustom("=======================}");
  }

  getTunePrice() {
    AppSettingModel? setting = StoreManager().appSetting;
    var items = setting?.responseMap!.settings!.others!.tonePrice;
    printCustom("Tune price is =======================${items}");
  }

  updateIndex(int index) {
    this.index.value = index;
  }
}
/*
getTunePrice() async {
    this.setting = setting;
    var items = setting.responseMap!.settings!.others!.entries;
    customPrint("items is ${items}");

    var recomTab = await items.map((e) {
      if (e.key == ("TONE_PRICE")) {
        tunePrice = e.value.attribute ?? "No";

        customPrint("Tab item is ======1 ${tunePrice}");
      }
      ;
      customPrint("Tab item is ======3 ${tunePrice}");
      return tunePrice;
    });
    customPrint("Tune prince is=== ${tunePrice}========== ${recomTab}");
    return tunePrice;
  }
  */