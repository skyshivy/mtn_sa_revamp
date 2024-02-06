import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

import '../../../../../custom_files/custom_buttons/custom_button.dart';

class HomeSearchButton extends StatelessWidget {
  final Function() onTap;
  final double width;
  final double height;
  const HomeSearchButton(
      {super.key, required this.onTap, this.width = 47, this.height = 47});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        color: white,
        width: width,
        height: height,
        leftWidget: Image.asset(
          searchImg,
          height: 20,
          width: 20,
          color: blue,
        ),
        onTap: onTap,
      ),
    );
  }
}
