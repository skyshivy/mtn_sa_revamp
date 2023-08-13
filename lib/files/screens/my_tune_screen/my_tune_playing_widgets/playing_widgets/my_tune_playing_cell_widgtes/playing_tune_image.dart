import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget playingTuneImageWidget() {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      const CustomImage(),
      _playingTuneLikeButton(),
    ],
  );
}

Widget _playingTuneLikeButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        CustomButton(
          height: 30,
          color: whiteTrans,
          titlePadding: EdgeInsets.only(left: 4, right: 12),
          leftWidget: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset(
              likeImg,
              height: 15,
              width: 15,
            ),
          ),
          title: "23",
          fontName: FontName.medium,
        ),
      ],
    ),
  );
}
