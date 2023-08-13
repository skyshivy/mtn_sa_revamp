import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneStatus() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [_status(), _callers(), _playAt()],
  );
}

Widget _status() {
  return _titleSubTitleWidget(statusStr, shuffleStr);
}

Widget _callers() {
  return _titleSubTitleWidget(callersStr, allStr);
}

Widget _playAt() {
  return _titleSubTitleWidget(playAtStr, fulldayStr);
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
