import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

profileEditButton() {
  ProfileController controller = Get.find();
  return controller.isSaving.value
      ? loadingIndicator(radius: 12)
      : CustomButton(
          color: yellow,
          fontName: FontName.medium,
          title: controller.editEnable.value ? saveStr : editStr,
          onTap: () {
            controller.editButtonAction();
          },
        );
}
