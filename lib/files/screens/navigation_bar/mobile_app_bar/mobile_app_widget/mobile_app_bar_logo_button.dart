import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget mobileAppBarLogoButton() {
  PlayerController con = Get.find();
  return Center(
    child: CustomButton(
      onTap: () {
        con.stop();
        Get.until((route) => Get.currentRoute == '/');
      },
      leftWidget: Image.asset(
        logoBigImg,
        height: 40,
        width: 40,
      ),
    ),
  );
}
