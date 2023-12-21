import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/localization/localizatio_service.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
  //bool testBool = false;
  int otpLength = 6;
  int msisdnLength = 10;
  int timeOutDuration = 15;
  late Box<dynamic> prefs;

  //final storage = FlutterSecureStorage();
  //late SharedPreferences prefs;
  AppSettingModel? appSetting;

  Future<void> initStoreManager() async {
    print("before init manager initialized");
    prefs = await Hive.openBox('StoreManager');
    prefs = Hive.box("StoreManager");
    print("Store manager initialized");
    //prefs = await SharedPreferences.getInstance();
    //String v = await storage.read(key: "isLoggedIn") ?? 'no';
    //isLoggedIn = (v == "yes") ? true : false;

    isEnglish = prefs.get("isEnglish") ?? true;
    //isEnglish = prefs.getBool("isEnglish") ?? true;

    isLoggedIn = prefs.get("isLoggedIn") ?? false;
    //isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    //testBool = prefs.get(isLoggedIn) ?? false;
    //testBool = prefs.getBool("TestBool") ?? false;

    //accessToken = await storage.read(key: "accessToken") ?? '';
    //accessToken = prefs.getString("accessToken") ?? '';
    accessToken = prefs.get("accessToken") ?? '';

    //deviceId = await storage.read(key: "deviceId") ?? '';
    //deviceId = prefs.getString("deviceId") ?? '';
    deviceId = prefs.get("deviceId") ?? '';

    //msisdn = await storage.read(key: "msisdn") ?? '';
    //msisdn = prefs.getString("msisdn") ?? '';
    msisdn = prefs.get("msisdn") ?? '0';

    //refreshToken = await storage.read(key: "refreshToken") ?? '';
    //refreshToken = prefs.getString("refreshToken") ?? '';
    refreshToken = prefs.get("refreshToken") ?? '';

    //ccid = await storage.read(key: "ccid") ?? '';
    //ccid = prefs.getString('ccid') ?? '';
    ccid = prefs.get('ccid') ?? '';

    //userName = await storage.read(key: "userName") ?? '';
    //userName = prefs.getString('userName') ?? '';
    userName = prefs.get('userName') ?? '';

    //password = await storage.read(key: "password") ?? 'Oem@L#@1';
    //password = prefs.getString('password') ?? 'Oem@L#@1';
    password = prefs.get('password') ?? 'Oem@L#@1';

    //channelId = await storage.read(key: "channelId") ?? '4';
    //channelId = prefs.getString('channelId') ?? '4';
    channelId = prefs.get('channelId') ?? channelId;

    appController.isEnglish.value = isEnglish;
    languageCode = isEnglish ? "1" : "2";
    language = isEnglish ? "English" : "Burmese";
    appController.isLoggedIn.value = isLoggedIn;
    //appController.testBool.value = testBool;
    return;
  }

  Future<void> storeAppSettingModel(AppSettingModel settingModel) async {
    appSetting = settingModel;
    return;
  }

  Future<void> logout() async {
    setAccessToken('');
    setDeviceId('');
    setMsisdn('0');
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

  setTestBool(bool value) async {
    //testBool = value;
    appController.testBool.value = value;
    try {
      //prefs.setBool('TestBool', value);
      prefs.put('TestBool', value);
      //storage.write(key: 'TestBool', value: value ? 'yes' : 'no');
    } on Exception catch (e) {
      print("Error saving isLoogedin = ${e.toString()}");
    }

    print("Storing isLoggedin = $value");
  }

  setLanguageEnglish(bool english) async {
    isEnglish = english;
    language = isEnglish ? "English" : "Burmese";
    languageCode = isEnglish ? "1" : "2";
    appController.isEnglish.value = english;
    LocalizationService().changeLocale(isEnglish);
    try {
      prefs.put('isEnglish', english);
      //prefs.setBool('isEnglish', english);
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
      prefs.put('msisdn', value);
      //prefs.setString('msisdn', value);
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
      prefs.put('ccid', value);
      //prefs.setString('ccid', value);

      //storage.write(key: 'ccid', value: value);
    } on Exception catch (e) {
      print("Error saving ccid = ${e.toString()}");
    }
  }

  setUserName(String value) async {
    userName = value;
    print("Storing userName = $value");
    try {
      prefs.put('userName', value);
      //prefs.setString('userName', value);

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
      prefs.put('password', value);
      //prefs.setString('password', value);

      //storage.write(key: 'password', value: value);
    } on Exception catch (e) {
      print("Error saving password = ${e.toString()}");
    }
  }

  setChannelId(String value) async {
    if (value.isEmpty) {
      value = channelId;
    }
    channelId = value;
    print("Storing channelid = $value");

    try {
      prefs.put('channelId', value);
      //prefs.setString('channelId', value);
      //storage.write(key: 'channelId', value: value);
    } on Exception catch (e) {
      print("Error saving channelId = ${e.toString()}");
    }
  }

  setLoggedIn(bool value) async {
    isLoggedIn = value;
    appController.isLoggedIn.value = value;
    try {
      prefs.put('isLoggedIn', value);
      //prefs.setBool('isLoggedIn', value);
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
      prefs.put('accessToken', value);
      //prefs.setString('accessToken', value);
      //storage.write(key: 'accessToken', value: value);
    } on Exception catch (e) {
      print("Error saving accessToken = ${e.toString()}");
    }
  }

  setDeviceId(String value) async {
    deviceId = value;
    print("Storing device id = $value");
    try {
      prefs.put('deviceId', value);
      //prefs.setString('deviceId', value);
      //storage.write(key: 'deviceId', value: value);
    } on Exception catch (e) {
      print("Error saving deviceId = ${e.toString()}");
    }
  }

  setRefreshToken(String value) async {
    refreshToken = value;
    print("Storing refresh token = $value");
    try {
      prefs.put('refreshToken', value);
      //prefs.setString('refreshToken', value);
      //storage.write(key: 'refreshToken', value: value);
    } on Exception catch (e) {
      print("Error saving refreshToken = ${e.toString()}");
    }
  }
}
