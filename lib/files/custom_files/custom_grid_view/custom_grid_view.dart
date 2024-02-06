import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomGridView extends StatelessWidget {
  final List<TuneInfo> list;

  final Function()? onTap;
  final Widget? cell;
  final SliverGridDelegate? gridDelegate;
  const CustomGridView(
      {super.key,
      this.cell,
      required this.list,
      this.onTap,
      this.gridDelegate});

  @override
  Widget build(BuildContext context) {
    return gridView();
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            itemCount: list.length,
            shrinkWrap: true,
            gridDelegate: gridDelegate ??
                delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
            itemBuilder: (context, index) {
              return cell ?? homeCell(index, si);
            });
      },
    );
  }

  HomeTuneCell homeCell(int index, SizingInformation si) {
    return HomeTuneCell(
      si: si,
      info: list[index],
      index: index,
      onTap: onTap,
    );
  }
}
