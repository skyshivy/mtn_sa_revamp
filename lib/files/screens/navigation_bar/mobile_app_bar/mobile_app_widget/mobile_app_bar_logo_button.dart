import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget mobileAppBarLogoButton() {
  return Center(
    child: CustomButton(
      leftWidget: Image.asset(
        logoBigImg,
        height: 40,
        width: 40,
      ),
    ),
  );
}
