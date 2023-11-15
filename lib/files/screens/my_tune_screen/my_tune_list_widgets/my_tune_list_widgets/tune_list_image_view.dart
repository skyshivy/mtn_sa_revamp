import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_pay_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget tuneListImageView(ListToneApk1 info) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      CustomImage(
          url: info.toneDetails?.first.toneIdpreviewImageUrl,
          gradient: customGredient(blackGredient, blackGredient)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_tuneListLikeButton(info), _tuneListMoreButton()],
        ),
      )
    ],
  );
}

Widget _tuneListLikeButton(ListToneApk1 info) {
  return SizedBox();
  CustomButton(
    color: whiteTrans,
    height: 30,
    title: "",
    fontName: FontName.ztregular,
    titlePadding: const EdgeInsets.only(left: 4, right: 12),
    leftWidget: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Image.asset(
        likeImg,
        height: 15,
        width: 15,
      ),
    ),
  );
}

Widget _tuneListMoreButton() {
  return CustomButton(
    color: whiteTrans,
    height: 30,
    width: 30,
    leftWidget: const Icon(
      Icons.more_horiz,
      color: grey,
    ),
    onTap: () {
      print("_tuneListMoreButton");
    },
  );
}
