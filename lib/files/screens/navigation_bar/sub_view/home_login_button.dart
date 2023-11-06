import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeLoginButton extends StatelessWidget {
  const HomeLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 40,
      onTap: onTap,
      leftWidget: loaginLeftWidgetPadding(),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      titlePadding: const EdgeInsets.only(right: 15, left: 5),
      title: loginStr,
      fontSize: 16,
      fontName: FontName.medium,
      color: white,
    );
  }

  onTap() {
    printCustom("Get.isDialogOpen === ${Get.isDialogOpen}");
    if (Get.isDialogOpen ?? false) {
      Get.back();
      return;
    }

    Get.dialog(LoginScreen(), barrierDismissible: false);
    //Get.toNamed(loginTapped);
  }

  Padding loaginLeftWidgetPadding() {
    return const Padding(
      padding: EdgeInsets.only(left: 12),
      child: Icon(Icons.person_2_outlined, size: 20),
    );
  }
}
