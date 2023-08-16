import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
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
  AppController appController = Get.find();
  double mobileWidth = 500;
  bool isEnglish = true;
  String language = "English";
  String languageCode = "1";
  String msisdn = '';
  String accessToken = '';
  String deviceId = '';

  String refreshToken = '';

  bool isLoggedIn = false;
  int otpLength = 6;
  int msisdnLength = 10;
  int timeOutDuration = 15;
  late SharedPreferences prefs;
  late AppSettingModel appSetting;

  initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    accessToken = prefs.getString("accessToken") ?? '';
    deviceId = prefs.getString("deviceId") ?? '';
    msisdn = prefs.getString("msisdn") ?? '';
    refreshToken = prefs.getString("refreshToken") ?? '';
    appController.isLoggedIn.value = isLoggedIn;
  }

  storeAppSettingModel(AppSettingModel settingModel) async {
    appSetting = settingModel;
  }

  Future<void> logout() async {
    prefs.setString("accessToken", "");
    prefs.setString("deviceId", "");
    prefs.setString("msisdn", "");
    prefs.setString("refreshToken", "");
    prefs.setBool("isLoggedIn", false);
    appController.isLoggedIn.value = false;
    initStoreManager();
  }
}
