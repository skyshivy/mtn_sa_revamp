import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomefaqButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      fontName: FontName.bold,
      fontSize: 16,
      title: faq,
      onTap: () {
        print("HomefaqButton");
      },
    );
  }
}
