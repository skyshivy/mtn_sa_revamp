import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_widget/mobile_drawer_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MobileDrawer extends StatelessWidget {
  final MyDrawerController con = Get.find();
  final AppController appCont = Get.find();
  MobileDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      appCont.isLoggedIn.value ? con.createMenuList() : con.createMenuList();
      return Column(
        children: [
          Container(
            height: 56,
            color: blue,
          ),
          const SizedBox(height: 4),
          Expanded(child: listView(context)),
        ],
      );
    });
  }

  Widget listView(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (int i = 0; i < con.menuList.length; i++)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: mobileDrawerCell(context, con.menuList[i])),
      ],
    );
  }
}
