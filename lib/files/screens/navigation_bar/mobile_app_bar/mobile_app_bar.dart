import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_app_bar_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_drawer.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MobileAppBar extends StatelessWidget {
  MyDrawerController drawerController = Get.put(MyDrawerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: white,
        surfaceTintColor: white,
        child: MobileDrawer(),
      ),
      appBar: AppBar(
        leading: mobileAppBarLogoButton(),
        backgroundColor: yellow,
      ),
      body: WebLandingPage(),
    );
  }
}
