import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeAboutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      title: about,
      fontSize: 16,
      fontName: FontName.bold,
      onTap: () {
        print("HomefaqButton");
      },
    );
  }
}