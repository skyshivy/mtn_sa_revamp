import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

customEmptyTuneView({String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CustomText(
        title: title ?? tuneListEmptyStr.tr,
        fontName: FontName.bold,
      )
    ],
  );
}
