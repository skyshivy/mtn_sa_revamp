import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget playingTuneInfo(ListToneApk item) {
  return HomeCellTitleSubTilte(
    title: item.toneDetails?.first.toneName ?? '',
    subTitle: item.toneDetails?.first.artistName ??
        item.toneDetails?.first.albumName ??
        '',
    titleFontName: FontName.bold,
    titleFontSize: 16,
    subTitleFontName: FontName.regularItalic,
    subTitleFontSize: 12,
    subTitleColor: subTitleColor,
  );
}
