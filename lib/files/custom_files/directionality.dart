import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';

Widget widgetDirection(Widget widget) {
  AppController cont = Get.find();

  return Obx(() {
    return Directionality(
        textDirection:
            cont.isEnglish.value ? TextDirection.ltr : TextDirection.rtl,
        child: widget);
  });
}
