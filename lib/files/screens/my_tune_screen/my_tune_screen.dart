import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //MyTuneHeaderView(),
              //MyTunePlayingView(),
              //Flexible(child: MyTunePlayingView()),
              MyTuneListView(),
            ],
          ),
        ],
      ),
    );
  }
}
