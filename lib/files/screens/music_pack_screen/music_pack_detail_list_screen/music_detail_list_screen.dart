import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_detail_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_grid_view/custom_grid_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicPackDetailListScreen extends StatefulWidget {
  final String toneCode;
  final String type;
  const MusicPackDetailListScreen(
      {super.key, required this.toneCode, required this.type});
  @override
  State<StatefulWidget> createState() => _MusicPackDetailListScreenState();
}

class _MusicPackDetailListScreenState extends State<MusicPackDetailListScreen> {
  final MusicBoxDetailController cont = Get.find();
  @override
  void initState() {
    print("_MusicPackDetailListScreenState initialized");
    super.initState();
  }

  @override
  void dispose() {
    print("_MusicPackDetailListScreenState desposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return cont.isloading.value
          ? loadingIndicator()
          : Container(
              color: greyLight,
              child: gridView(),
            );
      CustomGridView(list: cont.list, onTap: () {}); //gridView();
    });
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: si.isMobile ? 12 : 30, vertical: 20),
          shrinkWrap: true,
          itemCount: cont.list.length,
          gridDelegate: delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
          itemBuilder: (context, index) {
            return HomeTuneCell(
              moreButtonWidget: SizedBox(
                height: 35,
              ),
              buttomButtonWidget: SizedBox(),
              index: index,
              info: cont.list[index],
            );
          },
        );
      },
    );
  }
}
//MusicBoxDetailController