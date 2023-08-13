import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_divider.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_image.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_info.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_more_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_play_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_repeat_day.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_status.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_time.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget myTunePlayingCell() {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: _myTunePlayingCellDecoration(),
    child: Column(
      children: [
        Expanded(child: playingTuneImageWidget()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _playingTuneInfoRow(),
              playingTuneDivider(),
              playingTuneStatus(),
              playingTuneDivider(),
              playingTuneTimeView(),
              playingTuneDivider(),
              playingTuneRepeatDays(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    ),
  );
}

Row _playingTuneInfoRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      playingTuneInfo(),
      Row(
        children: [
          playingTunePlayButton(),
          const SizedBox(width: 8),
          playingTuneMoreButton(),
        ],
      ),
    ],
  );
}

BoxDecoration _myTunePlayingCellDecoration() {
  return BoxDecoration(
    color: white,
    boxShadow: const [
      BoxShadow(color: blackGredient, spreadRadius: 1, blurRadius: 4)
    ],
    borderRadius: BorderRadius.circular(4),
  );
}
