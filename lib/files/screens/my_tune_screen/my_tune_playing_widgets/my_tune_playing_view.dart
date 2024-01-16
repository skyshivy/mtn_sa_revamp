import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/playing_tune_header.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTunePlayingView extends StatelessWidget {
  MyTunePlayingView({super.key});
  final MyTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: white),
          child: Column(
            children: [
              myTuneplayingHeaderView(),
              const SizedBox(height: 30),
              si.isMobile
                  ? SizedBox(height: 360, child: gridView(si))
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
          padding: const EdgeInsets.all(8),
          itemCount: controller.playingList.length,
          shrinkWrap: true,
          scrollDirection: si.isMobile ? Axis.horizontal : Axis.vertical,
          physics: si.isMobile ? null : const NeverScrollableScrollPhysics(),
          gridDelegate: _delegate(si),
          itemBuilder: (context, index) {
            var item = controller.playingList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: myTunePlayingCell(item, index),
            );
          },
        );
      },
    );
  }

  SliverGridDelegateWithMaxCrossAxisExtent _delegate(SizingInformation si) {
    return delegate(
      si,
      mainAxisExtent: si.isMobile ? 280 : 400,
      maxCrossAxisExtent: si.isMobile ? 420 : 380,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }
}
