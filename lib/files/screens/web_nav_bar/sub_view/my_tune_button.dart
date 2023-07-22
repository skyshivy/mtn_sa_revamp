import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeMyTuneButton extends StatelessWidget {
  WebTabController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      rightWidget: rightWidget(),
      title: myTune,
      fontName: FontName.bold,
      fontSize: 16,
      onTap: () {
        controller.loadPage(1);
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
