import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget tuneSettingCancelButton() {
  return CustomButton(
    titlePadding: const EdgeInsets.symmetric(horizontal: 20),
    fontName: FontName.medium,
    title: cancelStr.tr,
    borderColor: atomCryan,
    onTap: () {
      printCustom("Cancel button tapped");
    },
  );
}
