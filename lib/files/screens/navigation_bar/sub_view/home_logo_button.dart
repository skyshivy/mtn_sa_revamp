import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class HomePageLogoButton extends StatelessWidget {
  final Function() onTap;

  HomePageLogoButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      //color: white,
      leftWidgetPadding: const EdgeInsets.symmetric(horizontal: 10),
      radius: 2,
      leftWidget: Image.asset(
        atomLogoBigImg,
        height: 25,
        //width: 60,
        color: white,
        //color: ,
      ),
      onTap: () {
        onTap();
        context.go(homeGoRoute);
      },
    );
  }
}
