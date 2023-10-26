import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

playingTunePlayButton() {
  return const CustomButton(
    height: 40,
    width: 40,
    color: darkGreen,
    leftWidget: Icon(
      Icons.play_arrow,
      color: white,
    ),
  );
}
