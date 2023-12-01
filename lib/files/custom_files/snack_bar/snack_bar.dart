import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

showSnackBar({String message = "List is empty"}) {
  Get.snackbar("", "",
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
      backgroundColor: atomCryan,
      snackPosition: SnackPosition.BOTTOM,
      messageText: Center(
        child: CustomText(
          alignment: TextAlign.center,
          title: message,
          textColor: black,
          fontName: FontName.bold,
          fontSize: 16,
        ),
      ),
      maxWidth: 400);
}
