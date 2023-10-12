import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class AppController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxInt index = 0.obs;
  String tunePrice = '';
  settinApiCall() async {
    print("Setting api calling");
    var abc = await ServiceCall().getSetting(settingUrl);
    getTunePrice();
    print("=======================${abc}");
  }

  getTunePrice() {
    AppSettingModel setting = StoreManager().appSetting;
    var items = setting.responseMap!.settings!.others!.tonePrice;
    print("Tune price is =======================${items}");
  }

  updateIndex(int index) {
    this.index.value = index;
  }
}
/*
getTunePrice() async {
    this.setting = setting;
    var items = setting.responseMap!.settings!.others!.entries;
    print("items is ${items}");

    var recomTab = await items.map((e) {
      if (e.key == ("TONE_PRICE")) {
        tunePrice = e.value.attribute ?? "No";

        print("Tab item is ======1 ${tunePrice}");
      }
      ;
      print("Tab item is ======3 ${tunePrice}");
      return tunePrice;
    });
    print("Tune prince is=== ${tunePrice}========== ${recomTab}");
    return tunePrice;
  }
  */