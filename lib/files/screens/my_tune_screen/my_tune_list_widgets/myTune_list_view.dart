import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneListView extends StatelessWidget {
  MyTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: myTuneListHeaderView(),
              ),
              const SizedBox(height: 30),
              si.isMobile
                  ? SizedBox(height: 280, child: gridView(si))
                  : gridView(si),
            ],
          ),
        );
      },
    );
  }

  Widget gridView(SizingInformation si) {
    return Obx(
      () {
        return GridView.builder(
          padding: EdgeInsets.all(8),
          itemCount: controller.tuneList.length,
          scrollDirection: si.isMobile ? Axis.horizontal : Axis.vertical,
          physics: si.isMobile ? null : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: delegate(
            si,
            mainAxisExtent: si.isMobile ? 280 : 400,
            maxCrossAxisExtent: si.isMobile ? 420 : 380,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: tuneListCell(context, controller.tuneList[index], index),
            );
          },
        );
      },
    );
  }
}
