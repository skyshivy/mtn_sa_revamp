import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profilePreferenceWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
          title: preferenceStr, fontName: FontName.regular, fontSize: 14),
      SizedBox(height: 6),
      Row(
        children: [
          Flexible(
            child: Container(
              color: yellow,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        color: red,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    ],
  );
}
