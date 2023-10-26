import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mtn_sa_revamp/files/controllers/setting_controller.dart';
import 'package:mtn_sa_revamp/files/screens/setting_screen/widgets/setting_cell.dart';

class SettingListView extends StatelessWidget {
  SettingListView({super.key});
  final SettingController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cont.list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
          child: SettingCell(
            name: cont.list[index],
            index: index,
          ),
        );
      },
    );
  }
}
