import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

import '../../../../../custom_files/custom_text_field/custom_text_field.dart';

class HomeSearchTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final Function() onTap;
  final Color textColor;
  final Color hintColor;
  const HomeSearchTextField({
    super.key,
    required this.onChanged,
    required this.onSubmit,
    required this.onTap,
    this.textColor = black,
    this.hintColor = white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: transparent,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: CustomTextField(
          textColor: textColor,
          isBorder: false,
          hintColor: hintColor,
          fontName: FontName.mediumItalic,
          text: "",
          hintText: whatrLookingFor,
          fontSize: 16,
          onChanged: onChanged,
          onSubmit: onSubmit,
          onTap: onTap,
        ),
      )),
    );
  }
}
