import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreManager {
  static final StoreManager _instance = StoreManager._internal();

  StoreManager._internal() {
    initStoreManager();
    print("initiali stro manager");
  }
  factory StoreManager() {
    return _instance;
  }
  double mobileWidth = 500;
  bool isEnglish = true;
  String language = "English";
  String msisdn = '';
  int otpLength = 6;
  int msisdnLength = 9;
  int timeOutDuration = 15;
  late SharedPreferences prefs;
  late AppSettingModel appSetting;

  initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
  }

  storeAppSettingModel(AppSettingModel settingModel) async {
    appSetting = settingModel;
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
