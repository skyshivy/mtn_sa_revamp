import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomefaqButton extends StatelessWidget {
  WebTabController controller = Get.find();
  final Function() onTap;

  HomefaqButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      textColor: white,
      fontName: FontName.ztbold,
      fontSize: 16,
      title: faqStr,
      onTap: () {
        onTap();
        // controller.loadPage(2);
        // Get.back();
        // print("HomefaqButton");
      },
    );
  }
}
