import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

import '../../../../../custom_files/custom_buttons/custom_button.dart';

class HomeSearchButton extends StatelessWidget {
  final Function() onTap;

  const HomeSearchButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        color: white,
        width: 47,
        height: 47,
        leftWidget: Image.asset(
          searchImg,
          height: 20,
          width: 20,
          color: yellow,
        ),
        onTap: onTap,
      ),
    );
  }
}
