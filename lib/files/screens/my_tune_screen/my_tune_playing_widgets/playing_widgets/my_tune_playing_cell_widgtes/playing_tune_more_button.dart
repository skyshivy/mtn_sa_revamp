import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_more_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget playingTuneMoreButton(int index, TuneInfo info) {
  return MyTunePlayimgMoreButton(index: index, info: info);
  // const CustomButton(
  //   height: 40,
  //   width: 40,
  //   borderColor: grey,
  //   leftWidget: Icon(
  //     Icons.more_horiz,
  //     color: grey,
  //   ),
  // );
}
