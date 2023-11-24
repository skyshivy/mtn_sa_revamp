import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> storeAppSettingModel(AppSettingModel settingModel) async {
    appSetting = settingModel;
    return;
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
    return;
  }

  Future<void> setMsisdn(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('msisdn', value);
    msisdn = value;

    printCustom("Setting msisdn = $value");
    return;
  }

  Future<void> setccid(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ccid', value);
    ccid = value;
    return;
  }

  Future<void> setUserName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', value);
    userName = value;
    return;
  }

  Future<void> setPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.isEmpty) {
      value = 'Oem@L#@1';
    }

    await prefs.setString('password', value);
    password = value;
    return;
  }

  Future<void> setChannelId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.isEmpty) {
      value = '4';
    }
    await prefs.setString('channelId', value);
    channelId = value;
    return;
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    isLoggedIn = value;
    return;
  }

  Future<void> setAccessToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', value);
    accessToken = value;
    return;
  }

  Future<void> setDeviceId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceId', value);
    deviceId = value;
    return;
  }

  Future<void> setRefreshToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', value);
    refreshToken = value;
    return;
  }
}
