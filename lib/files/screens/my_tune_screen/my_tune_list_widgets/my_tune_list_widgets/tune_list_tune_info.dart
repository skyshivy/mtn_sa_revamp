import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget tuneListTuneInfo() {
  return HomeCellTitleSubTilte(
    title: "Blow My Mind",
    subTitle: "Davido",
    titleFontName: FontName.bold,
    titleFontSize: 16,
    subTitleFontName: FontName.regularItalic,
    subTitleFontSize: 12,
    subTitleColor: subTitleColor,
  );
}
