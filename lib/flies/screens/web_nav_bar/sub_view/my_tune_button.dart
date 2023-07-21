import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/flies/utility/string.dart';

class HomeMyTuneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      rightWidget: rightWidget(),
      title: myTune,
      fontName: FontName.bold,
      fontSize: 16,
      onTap: () {
        print("On tap HomeMyTuneButton");
      },
    );
  }

  Padding rightWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 2),
      child: Icon(Icons.arrow_drop_down_outlined),
    );
  }
}
