import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_header_widgets/widgets/my_tune_oval_shape.dart';

import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class MyTuneHeaderView extends StatelessWidget {
  const MyTuneHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      //color: Colors.teal,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Image.asset(
            myTunesHeaderImg,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(right: -80, child: myTuneOvalShapre()),
        ],
      ),
    );
  }
}
