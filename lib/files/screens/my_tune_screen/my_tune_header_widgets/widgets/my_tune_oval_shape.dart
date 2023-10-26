import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget myTuneOvalShapre() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ClipOval(
        child: Container(
          color: darkGreen,
          height: 200,
          width: 320,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: _title(),
          ),
        ),
      ),
    ],
  );
}

Widget _title() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: setYourTunesStr,
        fontName: FontName.ztbold,
        fontSize: 20,
        textColor: white,
      ),
      CustomText(
        title: customiseYourTunesStr,
        fontName: FontName.abook,
        fontSize: 16,
        textColor: white,
      ),
    ],
  );
}
