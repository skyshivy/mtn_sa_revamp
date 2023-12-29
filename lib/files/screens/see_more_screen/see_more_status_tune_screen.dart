import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/home_status_tone_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/custom_files/set_tune_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/set_tune_popup/set_tune_popup.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeeMoreStatusTuneScreen extends StatelessWidget {
  HomeStatusToneController cont = Get.find();

  SeeMoreStatusTuneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          children: [
            CustomTopHeaderView(title: statusTuneStr.tr),
            Expanded(child: gridViewBuilder(si)),
          ],
        );
      },
    );
  }

  Widget gridViewBuilder(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
      child: GridView.builder(
        itemCount: cont.tuneList.length,
        shrinkWrap: true,
        gridDelegate: delegate(si),
        itemBuilder: (context, index) {
          return HomeTuneCell(
            info: cont.tuneList[index],
            index: index,
            button: setButton(cont.tuneList[index]),
            onTap: () {
              print("Tapped index");
              si.isMobile
                  ? pushToTunePreView(context, cont.tuneList, index)
                  : Null;
            },
          );
        },
      ),
    );
  }
}
