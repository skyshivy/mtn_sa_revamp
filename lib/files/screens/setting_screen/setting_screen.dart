import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/files/screens/setting_screen/widgets/setting_list_view.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          appBgImage,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height / 4,
        ),
        const SizedBox(height: 10),
        Expanded(child: SettingListView()),
        const SizedBox(height: 10),
      ],
    );
  }
}
