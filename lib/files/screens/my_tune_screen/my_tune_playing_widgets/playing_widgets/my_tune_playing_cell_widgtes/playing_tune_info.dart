import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneInfo(ListToneApk item) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      homeCellTitleSubTilte(
        title: item.toneDetails?.first.toneName ?? '',
        subTitle: item.toneDetails?.first.artistName ??
            item.toneDetails?.first.albumName ??
            '',
        titleFontName: FontName.bold,
        titleFontSize: 16,
        subTitleFontName: FontName.mediumItalic,
        subTitleFontSize: 12,
        subTitleColor: subTitleColor,
      ),
      CustomText(
        title: "$tuneCodeStr : ${item.toneDetails?.first.toneId ?? ''}",
        fontName: FontName.mediumItalic,
        fontSize: 12,
        textColor: subTitleColor,
      )
    ],
  );
}
