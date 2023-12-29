import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomGridView extends StatelessWidget {
  final int itemCount;
  final List<TuneInfo> list;
  final Function() onTap;
  const CustomGridView(
      {super.key,
      required this.itemCount,
      required this.list,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return gridView();
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return GridView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              gridDelegate:
                  delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return homeCell(index);
              });
        });
      },
    );
  }

  HomeTuneCell homeCell(int index) {
    return HomeTuneCell(
      info: list[index],
      index: index,
      onTap: onTap,
    );
  }
}
