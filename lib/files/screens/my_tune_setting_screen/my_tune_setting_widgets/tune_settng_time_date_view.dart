import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/style.dart';

class TuneSettingTimeDateView extends StatelessWidget {
  TuneSettingTimeDateView({super.key});
  final TuneSettingController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        height: 60,
        width: 300,
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
                      onTap: () async {
                        await fromDateTapped(context);
                      },
                      child:
                          titleSubtitleWidget(fromDateStr, "05-10-23, 10:20")),
                  InkWell(
                      onTap: () async {
                        await toDateTapped(context);
                      },
                      child: titleSubtitleWidget(toDateStr, "16-12-26, 16:50")),
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

  Future<void> fromDateTapped(BuildContext context) async {
    print("From Date tapped");
    con.openCalenderView(context);
  }

  toDateTapped(BuildContext context) async {
    print("To Date tapped");
    con.openCalenderView(context);
  }
}
