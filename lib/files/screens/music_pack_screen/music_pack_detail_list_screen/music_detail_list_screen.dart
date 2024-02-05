import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_detail_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_empty_tune_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_grid_view/custom_grid_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
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
    printCustom("_MusicPackDetailListScreenState initialized");

    super.initState();
  }

  @override
  void dispose() {
    printCustom("_MusicPackDetailListScreenState desposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(
          title: musicPackStr.tr,
          onTap: () {
            context.goNamed(musicPackGoRoute);
          },
        ),
        Expanded(
          child: Obx(() {
            return cont.isloading.value
                ? loadingIndicator()
                : Container(
                    color: cont.list.isEmpty ? transparent : greyLight,
                    child: gridView(),
                  );
            CustomGridView(list: cont.list, onTap: () {}); //gridView();
          }),
        ),
      ],
    );
  }

  Widget gridView() {
    return Obx(() {
      return cont.list.isEmpty
          ? customEmptyTuneView()
          : ResponsiveBuilder(
              builder: (context, si) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: si.isMobile ? 12 : 30, vertical: 20),
                  shrinkWrap: true,
                  itemCount: cont.list.length,
                  gridDelegate:
                      delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
                  itemBuilder: (context, index) {
                    return HomeTuneCell(
                      si: si,
                      moreButtonWidget: SizedBox(
                        height: 35,
                      ),
                      buttomButtonWidget: SizedBox(),
                      index: index,
                      info: cont.list[index],
                      onTap: () {
                        if (si.isMobile) {
                          pushToTunePreView(context, cont.list, index);
                        }
                      },
                    );
                  },
                );
              },
            );
    });
  }
}
//MusicBoxDetailController