import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget playingTuneImageWidget(ListToneApk? item) {
  return Stack(
    alignment: Alignment.topLeft,
    children: [
      CustomImage(
        url: item?.toneDetails?.first.toneIdpreviewImageUrl,
        gradient: customGredient(blackGredient, blackGredient),
      ),
      _playingTuneLikeButton(),
    ],
  );
}

Widget _playingTuneLikeButton() {
  return SizedBox();
  Padding(
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
          fontName: FontName.abook,
        ),
      ],
    ),
  );
}
