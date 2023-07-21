import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/flies/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';

class HomePageLogoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      leftWidget: Image.asset(
        logoBigImg,
        height: 60,
        width: 60,
      ),
    );
  }
}
