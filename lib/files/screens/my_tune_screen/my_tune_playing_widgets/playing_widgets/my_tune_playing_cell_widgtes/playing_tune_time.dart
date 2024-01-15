import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget playingTuneTimeView(ListToneApk item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _startTime(item),
      _endTime(item),
    ],
  );
}

Widget _startTime(ListToneApk item) {
  return _titleSubTitleWidget(startTimeStr.tr, item.sTime ?? '');
}

Widget _endTime(ListToneApk item) {
  return _titleSubTitleWidget(startTimeStr.tr, item.eTime ?? '');
}

Widget _titleSubTitleWidget(String title, String subTitle) {
  return HomeCellTitleSubTilte(
    title: title,
    subTitle: subTitle,
    titleColor: subTitleColor,
    titleFontSize: 13,
    titleFontName: FontName.light,
    subTitleFontName: FontName.medium,
    subTitleFontSize: 13,
  );
}
