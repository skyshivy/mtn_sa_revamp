import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneSettingTuneInfo() {
  TuneSettingController con = Get.find();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      homeCellTitleSubTilte(
        title: con.tuneName,
        titleFontName: FontName.bold,
        titleFontSize: 16,
        subTitle: con.tuneArtist,
        subTitleFontName: FontName.mediumItalic,
        subTitleFontSize: 14,
        subTitleColor: subTitleColor,
      ),
      CustomText(
        title: "${tuneCodeStr.tr} : ${con.tuneId}",
        fontName: FontName.mediumItalic,
        fontSize: 14,
        textColor: subTitleColor,
      )
    ],
  );
}
