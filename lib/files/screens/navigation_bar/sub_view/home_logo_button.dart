import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class HomePageLogoButton extends StatelessWidget {
  WebTabController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: white,
      leftWidgetPadding: const EdgeInsets.symmetric(horizontal: 10),
      radius: 2,
      leftWidget: Image.asset(
        atomLogoBigImg,
        height: 60,
        width: 60,
        //color: ,
      ),
      onTap: () {
        Get.until((route) => Get.currentRoute == '/');
        controller.loadPage(0);
      },
    );
  }
}
