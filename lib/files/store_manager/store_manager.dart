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

  setMsisdn(String value) async {
    msisdn = value;
    print("Storing msisdn = $msisdn");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('msisdn', value);
    } catch (e) {
      print("Error saving msisdn = ${e.toString()}");
    }

    printCustom("Setting msisdn = $value");
  }

  setccid(String value) async {
    ccid = value;
    print("Storing ccid = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('ccid', value);
    } on Exception catch (e) {
      print("Error saving ccid = ${e.toString()}");
    }
  }

  setUserName(String value) async {
    userName = value;
    print("Storing userName = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', value);
    } on Exception catch (e) {
      print("Error saving msuserName is = ${e.toString()}");
    }
  }

  setPassword(String value) async {
    if (value.isEmpty) {
      value = 'Oem@L#@1';
    }
    password = value;
    print("Storing password = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('password', value);
    } on Exception catch (e) {
      print("Error saving password = ${e.toString()}");
    }
  }

  setChannelId(String value) async {
    if (value.isEmpty) {
      value = '4';
    }
    channelId = value;
    print("Storing channelid = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('channelId', value);
    } on Exception catch (e) {
      print("Error saving channelId = ${e.toString()}");
    }
  }

  setLoggedIn(bool value) async {
    isLoggedIn = value;
    print("Storing isLoggedin = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', value);
    } on Exception catch (e) {
      print("Error saving isLoogedin = ${e.toString()}");
    }
  }

  setAccessToken(String value) async {
    accessToken = value;
    print("Storing accessToken = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', value);
    } on Exception catch (e) {
      print("Error saving accessToken = ${e.toString()}");
    }
  }

  setDeviceId(String value) async {
    deviceId = value;
    print("Storing device id = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('deviceId', value);
    } on Exception catch (e) {
      print("Error saving deviceId = ${e.toString()}");
    }
  }

  setRefreshToken(String value) async {
    refreshToken = value;
    print("Storing refresh token = $value");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('refreshToken', value);
    } on Exception catch (e) {
      print("Error saving refreshToken = ${e.toString()}");
    }
  }
}
