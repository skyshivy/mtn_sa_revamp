import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profileActiveStatus() {
  return ResponsiveBuilder(
    builder: (context, si) {
      return CustomText(
        title: noActivePlanStr,
        textColor: subTitleColor,
        fontName: si.isMobile ? FontName.bold : FontName.regular,
        fontSize: 14,
      );
    },
  );
}
