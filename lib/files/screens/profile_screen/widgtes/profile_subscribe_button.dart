import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profileSubscribeButtonWidget(Function()? onTap) {
  return SizedBox(
    width: 120,
    child: CustomButton(
      color: yellow,
      title: subscribeStr,
      fontName: FontName.bold,
      fontSize: 16,
      onTap: onTap,
    ),
  );
}
