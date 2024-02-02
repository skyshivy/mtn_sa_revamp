import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget tuneListTuneInfo(ListToneApk1 info) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      homeCellTitleSubTilte(
        title: info.toneDetails?.first.toneName,
        subTitle: info.toneDetails?.first.artistName ??
            info.toneDetails?.first.albumName ??
            "",
        titleFontName: FontName.bold,
        titleFontSize: 16,
        subTitleFontName: FontName.mediumItalic,
        subTitleFontSize: 12,
        subTitleColor: subTitleColor,
      ),
      CustomText(
        title: "${tuneCodeStr.tr} : ${info.toneDetails?.first.toneId ?? ''}",
        fontName: FontName.mediumItalic,
        fontSize: 12,
        textColor: subTitleColor,
      )
    ],
  );
}
