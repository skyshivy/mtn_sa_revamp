import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';

class MyTuneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTuneScreenState();
  }
}

class _MyTuneScreenState extends State<MyTuneScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CustomText(
      title: "_MyTuneScreenState",
      fontName: FontName.bold,
      fontSize: 20,
    ));
  }
}
