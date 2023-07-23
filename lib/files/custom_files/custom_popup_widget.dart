import 'package:flutter/cupertino.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget,
          ],
        ),
      ),
    ),
  );
}
