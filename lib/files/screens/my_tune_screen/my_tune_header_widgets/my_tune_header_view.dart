import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_header_widgets/widgets/my_tune_oval_shape.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MyTuneHeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      color: Colors.teal,
      child: myTuneOvalShapre(),
    );
  }
}
