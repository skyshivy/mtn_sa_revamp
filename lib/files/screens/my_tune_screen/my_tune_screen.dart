import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_header_widgets/my_tune_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/myTune_list_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/my_tune_playing_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class MyTuneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTuneScreenState();
  }
}

class _MyTuneScreenState extends State<MyTuneScreen> {
  late MyTuneController controller;
  @override
  void initState() {
    print("initState");
    controller = Get.put(MyTuneController());
    controller.getPlayingTuneList();
    super.initState();
  }

  @override
  void dispose() {
    print("Disposed");
    Get.delete<MyTuneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTuneHeaderView(),
            const SizedBox(height: 15),
            controller.isLoadingPlaying.value ? loadInd() : checkMyTuneEmpty(),
            const SizedBox(height: 35),
            controller.isLoadingTune.value ? loadInd() : checkMyTuneListEmpty(),
            const SizedBox(height: 200),
          ],
        );
      })),
    );
  }

  Widget checkMyTuneListEmpty() {
    return controller.playingList.isEmpty ? listIsEmpty() : MyTuneListView();
  }

  Widget checkMyTuneEmpty() {
    return controller.playingList.isEmpty ? listIsEmpty() : MyTunePlayingView();
  }

  Widget listIsEmpty() {
    return const CustomText(
      title: tuneListEmptyStr,
      fontName: FontName.bold,
      fontSize: 20,
    );
  }

  Widget loadInd() {
    return SizedBox(height: 200, child: Center(child: loadingIndicator()));
  }
}
