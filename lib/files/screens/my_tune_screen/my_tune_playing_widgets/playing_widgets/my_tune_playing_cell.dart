import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_divider.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_image.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_info.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_more_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_play_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_repeat_day.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_status.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell_widgtes/playing_tune_time.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget myTunePlayingCell(ListToneApk item) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: _myTunePlayingCellDecoration(),
    child: Column(
      children: [
        Expanded(child: playingTuneImageWidget(item)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _playingTuneInfoRow(item),
              playingTuneDivider(),
              playingTuneStatus(item),
              playingTuneDivider(),
              playingTuneTimeView(item),
              repeatView(item),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget repeatView(ListToneApk item) {
  return (item.toneDetailTimeType == TimeType.monthly ||
          item.toneDetailTimeType == TimeType.yearly ||
          item.toneDetailTimeType == TimeType.none)
      ? const SizedBox()
      : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            playingTuneDivider(),
            playingTuneRepeatDays(item),
          ],
        );
}

Row _playingTuneInfoRow(ListToneApk item) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: playingTuneInfo(item)),
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
