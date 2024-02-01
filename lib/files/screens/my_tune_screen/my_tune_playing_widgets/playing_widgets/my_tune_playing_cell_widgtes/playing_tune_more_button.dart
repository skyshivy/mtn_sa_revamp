import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_more_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget playingTuneMoreButton(int index, TuneInfo info, bool isCrbt) {
  MyTuneController mCont = Get.find();

  return ResponsiveBuilder(
    builder: (context, si) {
      return CustomButton(
        height: 40,
        width: 40,
        borderColor: red,
        leftWidget: SvgPicture.asset(
          deleteSvg,
          height: 16,
          width: 16,
        ),
        onTap: () {
          Get.dialog(CustomConfirmAlertView(
            message: areYouSureYouWantToDeleteStr.tr,
            cancelTitle: cancelStr.tr,
            onOk: () {
              printCustom("delete tune called");
              mCont.deletePlayingTune(
                  info.toneId ?? '', index, isCrbt, context);
            },
          ));
        },
      );
    },
  );
  //MyTunePlayimgMoreButton(index: index, info: info);
}
