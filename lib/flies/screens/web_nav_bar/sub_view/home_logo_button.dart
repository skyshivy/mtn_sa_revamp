import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_buttons/image_button.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';

class HomePageLogoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ImageButton(
      height: 80,
      width: 80,
      imgName: logoBig,
    );
  }
}
