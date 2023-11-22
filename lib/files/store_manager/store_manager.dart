import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class StoreManager {
  static final StoreManager _instance = StoreManager._internal();

  StoreManager._internal() {
    initStoreManager();
    printCustom("initiali stro manager");
  }
  factory StoreManager() {
    return _instance;
  }
  AppController appController = Get.find();
  double mobileWidth = 500;
  bool isLoadWishlist = true;
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
  late AppSettingModel appSetting;

  initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    accessToken = prefs.getString("accessToken") ?? '';
    deviceId = prefs.getString("deviceId") ?? '';
    msisdn = prefs.getString("msisdn") ?? '';
    refreshToken = prefs.getString("refreshToken") ?? '';
    ccid = prefs.getString('ccid') ?? '';
    userName = prefs.getString('userName') ?? '';
    password = prefs.getString('password') ?? 'Oem@L#@1';
    channelId = prefs.getString('channelId') ?? '4';

    appController.isLoggedIn.value = isLoggedIn;
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
    setccid('');
    setUserName('');
    setPassword('');
    setChannelId('4');
    appController.isLoggedIn.value = false;
    initStoreManager();
  }

  setMsisdn(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('msisdn', value);
    msisdn = value;

    printCustom("Setting msisdn = $value");
  }

  setccid(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('ccid', value);
    ccid = value;
  }

  setUserName(String value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', value);
    userName = value;
  }

  setPassword(String value) async {
    if (value.isEmpty) {
      value = 'Oem@L#@1';
    }
    prefs = await SharedPreferences.getInstance();
    prefs.setString('password', value);
    password = value;
  }

  setChannelId(String value) async {
    if (value.isEmpty) {
      value = '4';
    }
    prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', value);
    channelId = value;
  }

  setLoggedIn(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
    isLoggedIn = value;
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
