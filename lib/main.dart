import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/web_landing_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_tab/web_tab_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getJson();
  AppController controller = Get.put(AppController());
  await controller.settinApiCall();
  runApp(const MyApp());
}

Future<String> getJson() async {
  final String value = await rootBundle.loadString('properties.json');
  final data = await json.decode(value);
  print("Json file is ${data}");
  baseUrl = data['BASE_URL'];
  baseUrlSecurity = data['BASE_URL_SECURITY'];
  print("Base url is ${baseUrl}");
  print("Base Security Url is ${baseUrlSecurity}");
  return value;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MTN_SA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Material(child: navBar(context)),
    );
  }

  Widget navBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        width < 700 ? mobileAppBar() : WebNavBarView(),
        const Expanded(
          child: SingleChildScrollView(
            child: WebLandingPage(),
          ),
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
