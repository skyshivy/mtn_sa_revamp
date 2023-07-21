import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class HomeCellTitleSubTilte extends StatelessWidget {
  final TuneInfo? info;

  const HomeCellTitleSubTilte({super.key, this.info});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: info?.toneName ?? info?.contentName ?? "",
          fontName: FontName.bold,
          fontSize: 18,
        ),
        CustomText(
          title: info?.albumName ?? info?.artistName ?? '',
          fontName: FontName.regularItalic,
          fontSize: 12,
          textColor: subTitleColor,
        ),
      ],
    );
  }
}
