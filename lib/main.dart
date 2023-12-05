// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/history_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/header_inrichment.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:url_strategy/url_strategy.dart';

BuildContext? goRouterContext;
FocusNode keyScrollFocusNode = FocusNode();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  //SharedPreferences.setMockInitialValues({});
  AppController controller = Get.put(AppController());
  initStoreManager();

// below line added to for dalay so can store manager can initialized
  await Future.delayed(const Duration(milliseconds: 500));
// above line added to for dalay so can store manager can initialized

  LoginController logCont = Get.put(LoginController());
  await getJson();

  controller.settinApiCall();

  CategoryPoupupController catCont = Get.put(CategoryPoupupController());
  SearchTuneController _ = Get.put(SearchTuneController());
  RecoController recCont = Get.put(RecoController());
  PlayerController playerController = Get.put(PlayerController());
  WebTabController tabController = Get.put(WebTabController());
  TunePreviewController preview = Get.put(TunePreviewController());
  BuyController buyController = Get.put(BuyController());
  CategoryController catDetailCont = Get.put(CategoryController());
  HistoryController hisCont = Get.put(HistoryController());
  MyDrawerController myDCont = Get.put(MyDrawerController());
  BannerController banCont = Get.put(BannerController());
  runApp(MyApp());
}

Future<void> initStoreManager() async {
  var box = await Hive.openBox('StoreManager');
  box = Hive.box("StoreManager");
  StoreManager().prefs = box;

  //StoreManager().prefs = await SharedPreferences.getInstance();
  await StoreManager().initStoreManager();
  return;
  //StoreManager().prefs = await SharedPreferences.getInstance();
}

Future<String> getJson() async {
  try {
    final String value = await rootBundle.loadString('properties.json');
    final data = await json.decode(value);
    baseUrl = data['BASE_URL'];
    faqUrl = data["FAQ_URL"];
    channelId = data['CHANNEL_ID'];
    resendOtpDuration = data['RESEND_OTP_DURATION'];
    baseUrlSecurity = data['BASE_URL_SECURITY'];
    timeOut = data['SESSION_TIME_OUT'];
    facebook_url = data['FACEBOOK_URL'];
    instagram_url = data['INSTAGRAM_URL'];
    twitter_url = data['TWITTER_URL'];
    linkedin_url = data['LINKEDIN_URL'];
    defaultImageUrl = data["DEFAULT_IMAGE_URL"];

    parseUrl();
    return value;
  } catch (e) {
    return '';
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  PlayerController playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: Duration(minutes: timeOut),
        invalidateSessionForUserInactivity: Duration(minutes: timeOut));

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        sessionLogoutTime();
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        sessionLogoutTime();
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: blue),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }

  void sessionLogoutTime() {
    if (StoreManager().isLoggedIn) {
      Get.dialog(CustomConfirmAlertView(
        message: sessionExpiredStr,
        onOk: () {
          goRouterContext?.go(homeGoRoute);
          StoreManager().logout();
        },
      ));
    }
  }
}






// MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'MTN_GENERIC',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: blue),
    //     useMaterial3: true,
    //   ),
    //   home: Material(
    //     child: Material(child: ResponsiveBuilder(
    //       builder: (context, si) {
    //         return navBar(context);
    //       },
    //     )),
    //   ),
    //   onGenerateRoute: (settings) {
    //     playerController.stop();
    //   },
    // );

//==================================================
  // Widget navBar(BuildContext context) {
  //   return ResponsiveBuilder(
  //     builder: (context, si) {
  //       return si.isMobile
  //           ? MobileHomeScreen()
  //           : Column(
  //               children: [
  //                 WebNavBarView(),
  //                 Expanded(
  //                   child: WebTabView(),
  //                 ),
  //               ],
  //             );
  //     },
  //   );
  // }
