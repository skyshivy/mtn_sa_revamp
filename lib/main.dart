// ignore_for_file: unused_local_variable, must_be_immutable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getJson();
  AppController controller = Get.put(AppController());
  controller.settinApiCall();
  StoreManager().initStoreManager();
  CategoryPoupupController catCont = Get.put(CategoryPoupupController());
  SearchTuneController _ = Get.put(SearchTuneController());
  PlayerController playerController = Get.put(PlayerController());
  WebTabController tabController = Get.put(WebTabController());
  TunePreviewController preview = Get.put(TunePreviewController());
  BuyController buyController = Get.put(BuyController());
  CategoryController catDetailCont = Get.put(CategoryController());

  runApp(MyApp());
}

Future<String> getJson() async {
  _headerInrichment();
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  baseUrl = data['BASE_URL'];
  faqUrl = data["FAQ_URL"];
  baseUrlSecurity = data['BASE_URL_SECURITY'];
  return value;
}

Future<void> _headerInrichment() async {}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  PlayerController playerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MTN GENERIC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
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
