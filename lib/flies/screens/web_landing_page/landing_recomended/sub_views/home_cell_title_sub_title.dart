import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

class HomeCellTitleSubTilte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "Blow My Mind",
          fontName: FontName.bold,
          fontSize: 18,
        ),
        CustomText(
          title: "Davido",
          fontName: FontName.regularItalic,
          fontSize: 12,
          textColor: subTitleColor,
        ),
      ],
    );
  }
}
