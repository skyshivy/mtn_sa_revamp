import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

import 'package:mtn_sa_revamp/flies/utility/colors.dart';
import 'package:mtn_sa_revamp/flies/utility/string.dart';

import '../../../../../custom_files/custom_text_field/custom_text_field.dart';

class HomeSearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: transparent,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomTextField(
          hintColor: white,
          fontName: FontName.regularItalic,
          text: "",
          hintText: whatrLookingFor,
          fontSize: 16,
          onChanged: (p0) {
            print("${p0}");
          },
          onSubmit: (p0) {
            print("Submitted value  = $p0");
          },
          onTap: () {
            print("Textfield tapped");
          },
        ),
      )),
    );
  }
}
