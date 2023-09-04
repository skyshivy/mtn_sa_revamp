import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profileSubscribeButtonWidget(SizingInformation si, Function()? onTap) {
  return SizedBox(
    width: si.isMobile ? null : 120,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 100 : 0),
      child: CustomButton(
        color: blue,
        title: subscribeStr,
        textColor: white,
        fontName: FontName.bold,
        fontSize: si.isMobile ? 12 : 16,
        onTap: onTap,
      ),
    ),
  );
}
