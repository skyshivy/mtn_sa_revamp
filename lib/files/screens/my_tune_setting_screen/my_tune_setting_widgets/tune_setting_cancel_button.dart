import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingCancelButton() {
  return CustomButton(
    titlePadding: const EdgeInsets.symmetric(horizontal: 20),
    fontName: FontName.ztregular,
    title: cancelStr,
    borderColor: blueLight,
    onTap: () {
      print("Cancel button tapped");
    },
  );
}
