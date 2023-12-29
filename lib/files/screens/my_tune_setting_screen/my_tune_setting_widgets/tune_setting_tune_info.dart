import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget tuneSettingTuneInfo() {
  TuneSettingController con = Get.find();
  return HomeCellTitleSubTilte(
    title: con.tuneName,
    titleFontName: FontName.aheavy,
    titleFontSize: 16,
    subTitle: con.tuneArtist,
    subTitleFontName: FontName.abook,
    subTitleFontSize: 14,
    subTitleColor: subTitleColor,
  );
}
