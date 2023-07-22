import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class HomePageLogoButton extends StatelessWidget {
  WebTabController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      leftWidget: Image.asset(
        logoBigImg,
        height: 60,
        width: 60,
      ),
      onTap: () {
        Get.until((route) => Get.currentRoute == '/');
        controller.loadPage(0);
      },
    );
  }
}
