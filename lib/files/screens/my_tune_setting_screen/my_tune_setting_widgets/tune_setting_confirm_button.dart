import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget tuneSettingConfirmButton() {
  TuneSettingController tuneController = Get.find();
  return ResponsiveBuilder(
    builder: (context, sizingInformation) {
      return Obx(
        () {
          return tuneController.isLoading.value
              ? SizedBox(
                  width: 160,
                  child:
                      Center(child: loadingIndicator(height: 40, radius: 15)))
              : CustomButton(
                  width: 160,
                  textColor: white,
                  titlePadding: const EdgeInsets.symmetric(horizontal: 20),
                  fontName: FontName.medium,
                  color: blue,
                  title: confirmStr,
                  onTap: () {
                    tuneController.setTune(context);
                    //customPrint("Confirm button tapped");
                  },
                );
        },
      );
    },
  );
}
