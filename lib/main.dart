import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_tab/web_tab_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getJson();
  AppController controller = Get.put(AppController());
  SearchTuneController _ = Get.put(SearchTuneController());
  controller.settinApiCall();
  runApp(const MyApp());
}

Future<String> getJson() async {
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  print("Json file is ${data}");
  baseUrl = data['BASE_URL'];
  faqUrl = data["FAQ_URL"];
  baseUrlSecurity = data['BASE_URL_SECURITY'];
  print("Base url is ${baseUrl}");
  print("Base Security Url is ${baseUrlSecurity}");
  return value;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTN_SA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return Material(child: navBar(context));
        //Material(
        //child: LoginScreen(),
        //); //Material(child: navBar(context));
      },
    );
  }

  Widget navBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width < 700 ? mobileAppBar() : WebNavBarView(),
        Expanded(
          child: WebTabView(),
        ),
      ],
    );
  }

  Container mobileAppBar() {
    return Container(
      height: 80,
      color: red,
    );
  }
}
