import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_header_widgets/my_tune_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/myTune_list_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/my_tune_playing_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';

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
    controller = Get.put(MyTuneController());
    controller.getPlayingList();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyTuneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTuneHeaderView(),
            const SizedBox(height: 15),
            const MyTunePlayingView(),
            const SizedBox(height: 35),
            MyTuneListView(),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
