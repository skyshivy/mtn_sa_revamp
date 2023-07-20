import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_buttons/image_button.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';

class HomeSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ImageButton(
        width: 47,
        iconHeight: 20,
        iconWidth: 20,
        color: white,
        imgName: logoBig,
      ),
    );
  }
}
