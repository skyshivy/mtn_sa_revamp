import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';

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
    return Obx(() {
      return GridView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          gridDelegate: delegate(),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return homeCell(index);
          });
    });
  }

  HomeTuneCell homeCell(int index) {
    return HomeTuneCell(
      info: list[index],
      index: index,
      onTap: onTap,
    );
  }

  SliverGridDelegateWithMaxCrossAxisExtent delegate() {
    return const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.911,
        mainAxisExtent: 280,
        maxCrossAxisExtent: 290,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20);
  }
}
