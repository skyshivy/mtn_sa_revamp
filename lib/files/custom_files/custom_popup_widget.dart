import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Future<dynamic> showPopup(
  Widget widget,
) {
  return Get.dialog(
      Center(
        child: Material(
          color: transparent,
          child: Scaffold(
            backgroundColor: transparent,
            body: Center(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false);
}
