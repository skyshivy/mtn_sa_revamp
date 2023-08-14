import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_cell.dart';

class MyTuneListView extends StatelessWidget {
  MyTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myTuneListHeaderView(),
        const SizedBox(height: 40),
        gridView(),
      ],
    );
  }

  Widget gridView() {
    return Obx(
      () {
        return GridView.builder(
          itemCount: controller.tuneList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: delegate(
              mainAxisExtent: 260,
              maxCrossAxisExtent: 320,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: tuneListCell(controller.tuneList[index]),
            );
          },
        );
      },
    );
  }
}
