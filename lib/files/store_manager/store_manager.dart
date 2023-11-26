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
  //final storage = FlutterSecureStorage();
  late SharedPreferences prefs;
  late AppSettingModel appSetting;

  Future<void> initStoreManager() async {
    prefs = await SharedPreferences.getInstance();
    //String v = await storage.read(key: "isLoggedIn") ?? 'no';
    //isLoggedIn = (v == "yes") ? true : false;
    isEnglish = prefs.getBool("isEnglish") ?? true;

    isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    //accessToken = await storage.read(key: "accessToken") ?? '';
    accessToken = prefs.getString("accessToken") ?? '';

    //deviceId = await storage.read(key: "deviceId") ?? '';
    deviceId = prefs.getString("deviceId") ?? '';

    //msisdn = await storage.read(key: "msisdn") ?? '';
    msisdn = prefs.getString("msisdn") ?? '';

    //refreshToken = await storage.read(key: "refreshToken") ?? '';
    refreshToken = prefs.getString("refreshToken") ?? '';

    //ccid = await storage.read(key: "ccid") ?? '';
    ccid = prefs.getString('ccid') ?? '';

    //userName = await storage.read(key: "userName") ?? '';
    userName = prefs.getString('userName') ?? '';

    //password = await storage.read(key: "password") ?? 'Oem@L#@1';
    password = prefs.getString('password') ?? 'Oem@L#@1';

    //channelId = await storage.read(key: "channelId") ?? '4';
    channelId = prefs.getString('channelId') ?? '4';
    appController.isEnglish.value = isEnglish;
    appController.isLoggedIn.value = isLoggedIn;
    return;
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
    //initStoreManager();
    return;
  }

  setLanguageEnglish(bool english) async {
    isEnglish = english;
    appController.isEnglish.value = english;
    try {
      prefs.setBool('isEnglish', english);
      //storage.write(key: 'isLoggedIn', value: value ? 'yes' : 'no');
    } on Exception catch (e) {
      print("Error saving isEnglish = ${e.toString()}");
    }

    print("Storing isLoggedin = $english");
  }

  setMsisdn(String value) async {
    msisdn = value;
    print("Storing msisdn = $msisdn");
    try {
      prefs.setString('msisdn', value);
      //storage.write(key: 'msisdn', value: value);
    } catch (e) {
      print("Print Error only  = $e");
      print("Error saving msisdn = ${e.toString()}");
    }

    printCustom("Setting msisdn = $value");
  }

  setccid(String value) async {
    ccid = value;
    print("Storing ccid = $value");
    try {
      prefs.setString('ccid', value);

      //storage.write(key: 'ccid', value: value);
    } on Exception catch (e) {
      print("Error saving ccid = ${e.toString()}");
    }
  }

  setUserName(String value) async {
    userName = value;
    print("Storing userName = $value");
    try {
      prefs.setString('userName', value);

      //storage.write(key: 'userName', value: value);
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
      prefs.setString('password', value);

      //storage.write(key: 'password', value: value);
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
      prefs.setString('channelId', value);
      //storage.write(key: 'channelId', value: value);
    } on Exception catch (e) {
      print("Error saving channelId = ${e.toString()}");
    }
  }

  setLoggedIn(bool value) async {
    isLoggedIn = value;
    appController.isLoggedIn.value = value;
    try {
      prefs.setBool('isLoggedIn', value);
      //storage.write(key: 'isLoggedIn', value: value ? 'yes' : 'no');
    } on Exception catch (e) {
      print("Error saving isLoogedin = ${e.toString()}");
    }

    print("Storing isLoggedin = $value");
  }

  setAccessToken(String value) async {
    accessToken = value;
    print("Storing accessToken = $value");
    try {
      prefs.setString('accessToken', value);
      //storage.write(key: 'accessToken', value: value);
    } on Exception catch (e) {
      print("Error saving accessToken = ${e.toString()}");
    }
  }

  setDeviceId(String value) async {
    deviceId = value;
    print("Storing device id = $value");
    try {
      prefs.setString('deviceId', value);
      //storage.write(key: 'deviceId', value: value);
    } on Exception catch (e) {
      print("Error saving deviceId = ${e.toString()}");
    }
  }

  setRefreshToken(String value) async {
    refreshToken = value;
    print("Storing refresh token = $value");
    try {
      prefs.setString('refreshToken', value);
      //storage.write(key: 'refreshToken', value: value);
    } on Exception catch (e) {
      print("Error saving refreshToken = ${e.toString()}");
    }
  }
}
