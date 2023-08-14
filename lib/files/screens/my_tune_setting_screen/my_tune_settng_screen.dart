import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';

class MyTuneSettingScreen extends StatefulWidget {
  final String toneId;
  final String toneName;

  const MyTuneSettingScreen(
      {super.key, required this.toneId, required this.toneName});
  @override
  State<StatefulWidget> createState() {
    return _MyTuneSettingScreenState();
  }
}

class _MyTuneSettingScreenState extends State<MyTuneSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(title: widget.toneId),
        CustomText(title: widget.toneName)
      ],
    );
  }
}
