import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/playing_tune_header.dart';

class MyTunePlayingView extends StatelessWidget {
  MyTunePlayingView({super.key});
  MyTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myTuneplayingHeaderView(),
        const SizedBox(height: 30),
        gridView(),
      ],
    );
  }

  Widget gridView() {
    return Obx(
      () {
        return GridView.builder(
          itemCount: controller.playingList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: _delegate(),
          itemBuilder: (context, index) {
            var item = controller.playingList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: myTunePlayingCell(item),
            );
          },
        );
      },
    );
  }

  SliverGridDelegateWithMaxCrossAxisExtent _delegate() {
    return delegate(
      mainAxisExtent: 400,
      maxCrossAxisExtent: 320,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }
}
