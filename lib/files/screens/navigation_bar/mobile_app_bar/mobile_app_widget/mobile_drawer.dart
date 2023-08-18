import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/mobile_app_bar/mobile_app_widget/mobile_drawer_cell.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MobileDrawer extends StatelessWidget {
  MyDrawerController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Expanded(child: listView()),
      ],
    );
  }

  Widget listView() {
    return ListView(
      shrinkWrap: true,
      children: [
        for (int i = 0; i < con.menuList.length; i++)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: mobileDrawerCell(con.menuList[i])),
      ],
    );
  }
}
