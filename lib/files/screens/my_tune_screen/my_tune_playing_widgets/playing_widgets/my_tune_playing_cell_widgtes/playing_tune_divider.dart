import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget playingTuneDivider({double top = 8, double bottom = 8}) {
  return Padding(
    padding: EdgeInsets.only(top: top, bottom: bottom),
    child: const Divider(
      height: 1,
      color: grey,
    ),
  );
}
