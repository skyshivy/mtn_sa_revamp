import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_image_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_pay_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_setting.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_tune_info.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget tuneListCell(BuildContext context, ListToneApk1 info) {
  return Container(
      clipBehavior: Clip.hardEdge,
      decoration: _cellDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: tuneListImageView(info),
          ),
          _bottomSection(context, info),
          const SizedBox(height: 8),
        ],
      ));
}

Padding _bottomSection(BuildContext context, ListToneApk1 info) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: tuneListTuneInfo(info),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: tuneListPlayButton()),
            const SizedBox(width: 18),
            Expanded(child: tuneListSettingWidget(context, info))
          ],
        ),
      ],
    ),
  );
}

BoxDecoration _cellDecoration() {
  return BoxDecoration(
    color: white,
    boxShadow: const [
      BoxShadow(color: blackGredient, spreadRadius: 1, blurRadius: 4)
    ],
    borderRadius: BorderRadius.circular(4),
  );
}
