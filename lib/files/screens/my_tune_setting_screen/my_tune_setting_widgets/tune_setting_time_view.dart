import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class TuneSettingTimeView extends StatelessWidget {
  TuneSettingTimeView({super.key});
  TuneSettingController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 55,
        width: 250,
        decoration: _boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        fromTapped(context);
                      },
                      child: titleSubtitleWidget(fromTimeStr.tr, "10:20")),
                  InkWell(
                      onTap: () {
                        toTapped(context);
                      },
                      child: titleSubtitleWidget(toTimeStr.tr, "16:50")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: white);
  }

  Widget titleSubtitleWidget(String title, String subtitle) {
    return HomeCellTitleSubTilte(
      title: title,
      titleColor: subTitleColor,
      titleFontSize: 12,
      subTitle: subtitle,
      titleFontName: FontName.medium,
      subTitleColor: atomCryan,
      subTitleFontSize: 14,
      subTitleFontName: FontName.medium,
    );
  }

  fromTapped(BuildContext context) {
    printCustom("From time tapped");
    con.openCalenderView(context);
  }

  toTapped(BuildContext context) {
    printCustom("to time tapped");
    con.openCalenderView(context);
  }
}
