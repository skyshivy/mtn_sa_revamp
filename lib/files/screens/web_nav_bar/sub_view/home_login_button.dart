import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomButton(
        onTap: () {
          Get.toNamed(loginTapped);
        },
        leftWidget: Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(
            Icons.person_2_outlined,
            size: 20,
          ),
        ),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        titlePadding: EdgeInsets.only(right: 15, left: 5),
        title: login,
        fontSize: 16,
        fontName: FontName.medium,
        color: white,
      ),
    );
  }
}
