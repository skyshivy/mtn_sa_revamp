import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

FontName fontName(FontName phone, FontName desktop) {
  double widgt = Get.width;
  return widgt > StoreManager().mobileWidth ? desktop : phone;
}

bool isPhone(BuildContext context) {
  return !(MediaQuery.of(context).size.width > StoreManager().mobileWidth);
}

bool isMobile() {
  double widgt = Get.width;
  return (widgt > StoreManager().mobileWidth);
  // !(MediaQuery.of(context).size.width > StoreManager().mobileWidth);
}

double fontSize(double phone, double desktop) {
  double widgt = Get.width;
  return (widgt > StoreManager().mobileWidth) ? desktop : phone;
}
