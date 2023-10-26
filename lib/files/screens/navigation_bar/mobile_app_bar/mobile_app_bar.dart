import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_app_bar_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_drawer.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class MobileAppBar extends StatelessWidget {
  final Widget widget;
  final MyDrawerController drawerController = Get.put(MyDrawerController());
  final StatefulNavigationShell? navigationShell;
  MobileAppBar({super.key, required this.widget, this.navigationShell});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: white,
        surfaceTintColor: white,
        child: MobileDrawer(),
      ),
      appBar: AppBar(
        leading: mobileAppBarLogoButton(context),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: customGredient()),
        ),
        //backgroundColor: darkGreen,
      ),
      body: widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(gradient: customGredient()),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          fixedColor: red,
          showUnselectedLabels: true,
          unselectedItemColor: white,
          currentIndex: (navigationShell?.currentIndex ?? 0),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: homeStr),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: searchStr),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: salatiStr),
            BottomNavigationBarItem(
                icon: Icon(Icons.dirty_lens), label: diyStr),
            // BottomNavigationBarItem(icon: Icon(Icons.shop), label: diyStr),
          ],
          onTap: (index) {
            navigationShell?.goBranch(
              index,
              // A common pattern when using bottom navigation bars is to support
              // navigating to the initial location when tapping the item that is
              // already active. This example demonstrates how to support this behavior,
              // using the initialLocation parameter of goBranch.
              initialLocation: index == (navigationShell?.currentIndex ?? 0),
            );
          },
        ),
      ),
    );
  }
}
