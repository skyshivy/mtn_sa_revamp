import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:mtn_sa_revamp/files/screens/diy_screen/diy_mobile_view.dart';
import 'package:mtn_sa_revamp/files/screens/diy_screen/diy_sub_view/diy_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/diy_screen/diy_sub_view/diy_info.dart';
import 'package:mtn_sa_revamp/files/screens/diy_screen/diy_sub_view/diy_name_txtfld.dart';
import 'package:mtn_sa_revamp/files/screens/diy_screen/diy_sub_view/diy_upload_section.dart';

class DIYScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: GetPlatform.isWeb
            ? Column(
                children: [
                  DIYHeaderView(),
                  DiyInfo(),
                  DIYNameTextField(),
                  DIYUploadSection()
                ],
              )
            : DIYMobileView());
  }
}
