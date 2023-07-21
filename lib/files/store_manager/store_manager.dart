import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreManager {
  static final StoreManager _instance = StoreManager._internal();

  StoreManager._internal() {
    initStoreManager();
    print("initiali stro manager");
  }
  factory StoreManager() {
    print("Hello Sky ");

    return _instance;
  }

  late SharedPreferences prefs;
  late AppSettingModel appSetting;

  initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
  }

  resetData() async {}
}

// class StoreManager {
//   static final StoreManager _instance = StoreManager._internal();

//   StoreManager._internal() {
//     print("initiali stro manager");
//   }
//   late SharedPreferences prefs;
//   late AppSettingModel appSettingModel;
// }
