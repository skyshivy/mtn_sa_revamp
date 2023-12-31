import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget myTuneListHeaderView() {
  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _leftWidget(),
        SizedBox(height: 20, child: _rightWidget()),
      ],
    ),
  );
}

Widget _leftWidget() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: myTuneStr,
        fontName: FontName.bold,
        fontSize: 24,
      ),
      CustomText(
        title: howToPlaySelectedTunesToYourCallersStr,
        fontName: FontName.regular,
        textColor: subTitleColor,
        fontSize: 12,
      ),
    ],
  );
}

Widget _rightWidget() {
  return ListView(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    children: [
      _titleWidget(tunesStr, isBold: true),
      _divider(),
      _titleWidget(profileTunesStr),
      _divider(),
      _titleWidget(musicBundleStr),
    ],
  );
}

Widget _titleWidget(String title, {bool isBold = false}) {
  return CustomButton(
    onTap: () {
      print("tapped =============$title");
    },
    fontSize: 16,
    title: title,
    fontName: isBold ? FontName.bold : FontName.regular,
  );
}

Widget _divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: VerticalDivider(
      width: 1,
      thickness: 2,
      color: grey,
    ),
  );
}
