import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/gift_tune_view.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tunePreviewTellFriendView(
    TunePreviewController pCont, PlayerController playCont, TuneInfo info) {
  return Container(
    height: 60,
    decoration: _decoration(),
    child: InkWell(
      onTap: () {
        pCont.stopPlayer();
        Get.dialog(Center(
          child: GiftTuneView(
            info: info,
          ),
        ));
      },
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(tellFriendSvg),
          CustomText(
            title: giftStr.tr,
            fontName: FontName.medium,
            fontSize: 12,
          ),
        ],
      )),
    ),
  );
}

BoxDecoration _decoration() {
  return const BoxDecoration(
    color: greyLight,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
  );
}
