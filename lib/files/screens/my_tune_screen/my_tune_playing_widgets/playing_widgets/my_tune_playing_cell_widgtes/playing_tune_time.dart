import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneTimeView() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _startTime(),
      _endTime(),
    ],
  );
}

Widget _startTime() {
  return _titleSubTitleWidget(startTimeStr, "00:00");
}

Widget _endTime() {
  return _titleSubTitleWidget(startTimeStr, "23:59");
}

Widget _titleSubTitleWidget(String title, String subTitle) {
  return HomeCellTitleSubTilte(
    title: title,
    subTitle: subTitle,
    titleColor: subTitleColor,
    titleFontSize: 13,
    titleFontName: FontName.light,
    subTitleFontName: FontName.regular,
    subTitleFontSize: 13,
  );
}
