import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profileCancelButton() {
  ProfileController controller = Get.find();
  return CustomButton(
    title: cancelStr,
    color: transparent,
    fontName: FontName.abook,
    borderColor: lightGreen,
    onTap: () {
      controller.cancelButton();
    },
  );
}
