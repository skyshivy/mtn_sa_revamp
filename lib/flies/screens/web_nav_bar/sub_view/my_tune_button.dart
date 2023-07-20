import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_buttons/text_button.dart';

import 'package:mtn_sa_revamp/flies/utility/string.dart';

class HomeMyTuneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      title: myTune,
      onTap: () {
        print("On tap HomeMyTuneButton");
      },
    );
  }
}
