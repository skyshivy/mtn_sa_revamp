import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneStatus(ListToneApk item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _status(item),
      _callers(item),
      _playAt(item),
    ],
  );
}

Widget _status(ListToneApk item) {
  return _titleSubTitleWidget(item, statusStr, item.status ?? '');
}

Widget _callers(ListToneApk item) {
  return _titleSubTitleWidget(item, callersStr, item.callerType ?? '');
}

Widget _playAt(ListToneApk item) {
  return _titleSubTitleWidget(item, playAtStr, item.playAt ?? 'No');
}

Widget _titleSubTitleWidget(ListToneApk item, String title, String subTitle) {
  return HomeCellTitleSubTilte(
    title: title,
    subTitle: subTitle,
    titleColor: subTitleColor,
    titleFontSize: 13,
    titleFontName: FontName.abook,
    subTitleFontName: FontName.abook,
    subTitleFontSize: 13,
  );
}
