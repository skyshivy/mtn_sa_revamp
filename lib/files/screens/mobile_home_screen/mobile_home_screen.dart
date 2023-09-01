import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_bar.dart';

import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/utility/route_direction.dart';

class MobileHomeScreen extends StatelessWidget {
  MyDrawerController con = Get.put(MyDrawerController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: routesDirection,
      onGenerateRoute: (settings) {
        print("onGenerateRoute  ${settings.name}");
      },
      home: MobileAppBar(
        widget: WebLandingPage(),
      ),
    );
  }
}
