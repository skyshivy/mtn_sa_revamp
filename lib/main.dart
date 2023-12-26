import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/diy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/home_status_tone_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/setting_controller.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';

import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:url_strategy/url_strategy.dart';

late FocusNode mainFocusNode;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  mainFocusNode = FocusNode();
  await getJson();
  AppController controller = Get.put(AppController());
  SettingController settingCont = Get.put(SettingController());
  StoreManager().initStoreManager();
  CategoryPoupupController catCont = Get.put(CategoryPoupupController());
  SearchTuneController _ = Get.put(SearchTuneController());
  PlayerController playerController = Get.put(PlayerController());
  HomeStatusToneController statusToneCont = Get.put(HomeStatusToneController());
  TunePreviewController preview = Get.put(TunePreviewController());
  BuyController buyController = Get.put(BuyController());
  CategoryController catDetailCont = Get.put(CategoryController());
  DiyController diyCont = Get.put(DiyController());
  RecoController rec = Get.put(RecoController());
  controller.settinApiCall();
  if (kDebugMode) {
    StoreManager().msisdnLength = 10;
  } else {
    StoreManager().msisdnLength = 9;
  }
  runApp(MyApp());
}

Future<String> getJson() async {
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  baseUrl = data['BASE_URL'];
  faqUrl = data["FAQ_URL"];
  baseUrlSecurity = data['BASE_URL_SECURITY'];
  return value;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  PlayerController playerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Generic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkGreen),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}






// MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'MTN_GENERIC',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: darkGreen),
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
