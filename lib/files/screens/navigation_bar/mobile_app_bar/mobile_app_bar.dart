import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_app_bar_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_drawer.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MobileAppBar extends StatelessWidget {
  final Widget widget;
  final MyDrawerController drawerController = Get.find();

  MobileAppBar({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: white,
        surfaceTintColor: white,
        child: MobileDrawer(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: white,
        ),
        leading: mobileAppBarLogoButton(context),
        backgroundColor: blue,
      ),
      body: widget,
    );
  }
}
