import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profileUserName() {
  return SizedBox(
    width: 280,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: userNameStr,
          fontName: FontName.regular,
          fontSize: 14,
          textColor: subTitleColor,
        ),
        SizedBox(height: 6),
        CustomTextField(
          text: "",
          hintText: userNameStr,
        ),
      ],
    ),
  );
}
