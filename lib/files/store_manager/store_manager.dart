import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
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
  final storage = FlutterSecureStorage();
  //late SharedPreferences prefs;
  late AppSettingModel appSetting;

  Future<void> initStoreManager() async {
    //prefs = await SharedPreferences.getInstance();
    String v = await storage.read(key: "isLoggedIn") ?? 'no';
    isLoggedIn = (v == "yes") ? true : false;
    //isLoggedIn = isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    accessToken = await storage.read(key: "accessToken") ?? '';
    //accessToken = prefs.getString("accessToken") ?? '';

    deviceId = await storage.read(key: "deviceId") ?? '';

    ///deviceId = prefs.getString("deviceId") ?? '';

    msisdn = await storage.read(key: "msisdn") ?? '';
    //msisdn = prefs.getString("msisdn") ?? '';

    refreshToken = await storage.read(key: "refreshToken") ?? '';
    //refreshToken = prefs.getString("refreshToken") ?? '';

    ccid = await storage.read(key: "ccid") ?? '';
    //ccid = prefs.getString('ccid') ?? '';

    userName = await storage.read(key: "userName") ?? '';
    //userName = prefs.getString('userName') ?? '';

    password = await storage.read(key: "password") ?? '';
    //password = prefs.getString('password') ?? 'Oem@L#@1';

    channelId = await storage.read(key: "channelId") ?? '';
    //channelId = prefs.getString('channelId') ?? '4';

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

  setMsisdn(String value) async {
    msisdn = value;
    print("Storing msisdn = $msisdn");
    try {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('msisdn', value);

      storage.write(key: 'msisdn', value: value);
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
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('ccid', value);

      storage.write(key: 'ccid', value: value);
    } on Exception catch (e) {
      print("Error saving ccid = ${e.toString()}");
    }
  }

  setUserName(String value) async {
    userName = value;
    print("Storing userName = $value");
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('userName', value);

      storage.write(key: 'userName', value: value);
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
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('password', value);

      storage.write(key: 'password', value: value);
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
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('channelId', value);
      storage.write(key: 'channelId', value: value);
    } on Exception catch (e) {
      print("Error saving channelId = ${e.toString()}");
    }
  }

  setLoggedIn(bool value) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setBool('isLoggedIn', value);

      storage.write(key: 'isLoggedIn', value: value ? 'yes' : 'no');
    } on Exception catch (e) {
      print("Error saving isLoogedin = ${e.toString()}");
    }
    isLoggedIn = value;
    print("Storing isLoggedin = $value");
    appController.isLoggedIn.value = value;
  }

  setAccessToken(String value) async {
    accessToken = value;
    print("Storing accessToken = $value");
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('accessToken', value);
      storage.write(key: 'accessToken', value: value);
    } on Exception catch (e) {
      print("Error saving accessToken = ${e.toString()}");
    }
  }

  setDeviceId(String value) async {
    deviceId = value;
    print("Storing device id = $value");
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('deviceId', value);
      storage.write(key: 'deviceId', value: value);
    } on Exception catch (e) {
      print("Error saving deviceId = ${e.toString()}");
    }
  }

  setRefreshToken(String value) async {
    refreshToken = value;
    print("Storing refresh token = $value");
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('refreshToken', value);
      storage.write(key: 'refreshToken', value: value);
    } on Exception catch (e) {
      print("Error saving refreshToken = ${e.toString()}");
    }
  }
}
