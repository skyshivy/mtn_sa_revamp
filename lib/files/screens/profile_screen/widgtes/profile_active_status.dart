import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profileActiveStatus() {
  return const CustomText(
    title: noActivePlanStr,
    textColor: subTitleColor,
    fontName: FontName.regular,
    fontSize: 14,
  );
}
