import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/history_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/otp_timer_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_cell_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/header_inrichment.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:url_strategy/url_strategy.dart';

intialInitialization() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    printCustom('errro $e');
  }
  try {
    setPathUrlStrategy();
  } catch (e) {
    printCustom('errro $e');
  }
  //SharedPreferences.setMockInitialValues({});
  AppController controller = Get.put(AppController());

  _initStoreManager();

// below line added to for dalay so can store manager can initialized
  await Future.delayed(const Duration(milliseconds: 500));
// above line added to for dalay so can store manager can initialized

  LoginController logCont = Get.put(LoginController());
  try {
    await _getJson();
  } catch (e) {
    printCustom('errro $e');
  }
  try {
    controller.settinApiCall();
  } catch (e) {
    printCustom('errro $e');
  }
  try {
    _getPackStatus();
  } catch (e) {
    printCustom('errro $e');
  }
  CategoryPoupupController catCont = Get.put(CategoryPoupupController());
  SearchTuneController _ = Get.put(SearchTuneController());
  RecoController recCont = Get.put(RecoController());
  playerController = Get.put(PlayerController());
  WebTabController tabController = Get.put(WebTabController());
  TunePreviewController preview = Get.put(TunePreviewController());
  BuyController buyController = Get.put(BuyController());
  CategoryController catDetailCont = Get.put(CategoryController());
  HistoryController hisCont = Get.put(HistoryController());
  MyDrawerController myDCont = Get.put(MyDrawerController());
  BannerController banCont = Get.put(BannerController());
  otpController = Get.put(OtpTimerController());
  MyTuneController myTuneCon = Get.put(MyTuneController());
  WishlistController wishCont = Get.put(WishlistController());
  MusicPackController musicCont = Get.put(MusicPackController());
  TuneCellController tuneCont = Get.put(TuneCellController());
}

Future<void> _initStoreManager() async {
  var box = await Hive.openBox('StoreManager');
  box = Hive.box("StoreManager");
  StoreManager().prefs = box;

  //StoreManager().prefs = await SharedPreferences.getInstance();
  await StoreManager().initStoreManager();
  return;
  //StoreManager().prefs = await SharedPreferences.getInstance();
}

_getPackStatus() async {
  if (StoreManager().isLoggedIn) {
    PackStatusModel crbtPackStatusModel = await getPackStatusApiCall("");
    PackStatusModel rrbtPackStatusModel =
        await getPackStatusApiCall("", isCrbt: false);
    // if (packStatusModel.statusCode == "SC0000") {
    //   StoreManager().crbtPackStatus =
    //       packStatusModel.responseMap?.packStatusDetails;
    // } else {}
  } else {
    StoreManager().crbtPackStatus = null;
  }
}

Future<String> _getJson() async {
  try {
    final String value = await rootBundle.loadString('properties.json');
    final data = await json.decode(value);
    baseUrl = data['BASE_URL'];
    faqUrl = data["FAQ_URL"];
    channelId = data['CHANNEL_ID'];
    resendOtpDuration = data['RESEND_OTP_DURATION'];
    baseUrlSecurity = data['BASE_URL_SECURITY'];
    initialUrl = data['INITIAL_URL'];
    timeOut = data['SESSION_TIME_OUT'];
    facebookUrl = data['FACEBOOK_URL'];
    instagramUrl = data['INSTAGRAM_URL'];
    messangerUrl = data['MESSANGER_URL'];
    youtubeUrl = data['YOUTUBE_URL'];
    twitterUrl = data['TWITTER_URL'];
    linkedinUrl = data['LINKEDIN_URL'];
    defaultImageUrl = data["DEFAULT_IMAGE_URL"];

    parseUrl();
    return value;
  } catch (e) {
    return '';
  }
}