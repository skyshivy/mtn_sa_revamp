import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/localization/localizatio_service.dart';
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
  AppController appController = Get.find();
  double mobileWidth = 500;
  bool isEnglish = true;
  String language = "English";
  String languageCode = "1";
  String msisdn = '';
  String accessToken = '';
  String deviceId = '';
  String securityToken = '';
  String securityCounter = '';
  String refreshToken = '';

  bool isLoggedIn = false;
  int otpLength = 6;
  int msisdnLength = 10;
  int timeOutDuration = 15;
  late SharedPreferences prefs;
  AppSettingModel? appSetting;

  initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    accessToken = prefs.getString("accessToken") ?? '';
    deviceId = prefs.getString("deviceId") ?? '';
    msisdn = prefs.getString("msisdn") ?? '';
    refreshToken = prefs.getString("refreshToken") ?? '';
    appController.isLoggedIn.value = isLoggedIn;
    isEnglish = prefs.getBool("isEnglish") ?? true;
    appController.isEnglish.value = isEnglish;
  }

  storeAppSettingModel(AppSettingModel settingModel) async {
    appSetting = settingModel;
  }

  Future<void> logout() async {
    setAccessToken('');
    setDeviceId('');
    setMsisdn('');
    setRefreshToken('');
    setLoggedIn(false);

    appController.isLoggedIn.value = false;
    initStoreManager();
  }

  setMsisdn(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('msisdn', value);
    msisdn = value;
  }

  setLoggedIn(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);

    isLoggedIn = value;
  }

  setLanguage({required bool isEnglish}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEnglish);
    this.isEnglish = isEnglish;
    appController.isEnglish.value = isEnglish;
    LocalizationService().changeLocale(this.isEnglish);
  }

  setAccessToken(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', value);
    accessToken = value;
  }

  setDeviceId(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', value);
    deviceId = value;
  }

  setRefreshToken(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('refreshToken', value);
    refreshToken = value;
  }
}
