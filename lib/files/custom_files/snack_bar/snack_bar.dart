import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

showSnackBar({String message = "List is empty"}) {
  Get.snackbar(
    "",
    "",
    backgroundColor: blueLight,
    snackPosition: SnackPosition.BOTTOM,
    messageText: CustomText(
      alignment: TextAlign.center,
      title: message,
      textColor: black,
      fontName: FontName.ztbold,
      fontSize: 18,
    ),
  );
}
