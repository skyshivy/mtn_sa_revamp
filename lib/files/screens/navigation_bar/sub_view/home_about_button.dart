import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeAboutButton extends StatelessWidget {
  const HomeAboutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      title: aboutStr.tr,
      fontSize: 16,
      fontName: FontName.bold,
      onTap: () {
        //Get.toNamed(faqTapped);
        printCustom("HomefaqButton");
      },
    );
  }
}
