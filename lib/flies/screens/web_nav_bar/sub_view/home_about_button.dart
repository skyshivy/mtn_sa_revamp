import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/flies/utility/string.dart';

class HomeAboutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      title: about,
      onTap: () {
        print("HomefaqButton");
      },
    );
  }
}
