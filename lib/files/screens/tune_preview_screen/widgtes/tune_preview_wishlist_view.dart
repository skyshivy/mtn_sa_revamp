import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget tunePreviewWishlistView(
    TunePreviewController pCont, PlayerController playCont) {
  return Container(
    height: 60,
    decoration: _decoration(),
    child: InkWell(
      onTap: () {
        pCont.stopPlayer();
        printCustom("tunePreviewWishlistView tapped");
      },
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(wishlistSvg),
          const CustomText(
            title: wishlistStr,
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
