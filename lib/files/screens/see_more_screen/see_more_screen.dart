import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_cell_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:responsive_builder/responsive_builder.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  //TuneCellController cellCont = Get.find();
  RecoController recCont = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(
            title: recCont.tabTitle[recCont.selectedIndex.value]),
        Expanded(
          child: gridView(),
        ),
      ],
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        // cellCont.tuneList.value = recCont.displayList;
        // cellCont.si = si;
        // cellCont.isWishlist = false;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
          child: SingleChildScrollView(child: Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recCont.displayList.length,
              gridDelegate: delegate(si,
                  mainAxisExtent: si.isMobile ? 260 : null,
                  mainAxisSpacing: si.isMobile ? 8 : null,
                  crossAxisSpacing: si.isMobile ? 8 : null),
              itemBuilder: (context, index) {
                return //HomeTuneCell2(index: index);
                    HomeTuneCell(
                  si: si,
                  index: index,
                  info: recCont.displayList[index],
                  onTap: si.isMobile
                      ? () {
                          pushToTunePreView(
                              context, recCont.displayList, index);
                        }
                      : null,
                );
              },
            );
          })),
        );
      },
    );
  }
}
