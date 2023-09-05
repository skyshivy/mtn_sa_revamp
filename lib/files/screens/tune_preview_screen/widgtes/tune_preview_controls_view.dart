import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget tunePreviewControls_view(TunePreviewController cont) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _previousButton(cont),
      _playButton(cont),
      _nextButton(cont),
    ],
  );
}

Widget _nextButton(TunePreviewController cont) {
  return Obx(() {
    return cont.hideNext.value
        ? const SizedBox(width: 40)
        : Container(
            decoration: _shadowDecoration(),
            child: CustomButton(
              onTap: () {
                cont.nextTapped();
              },
              width: 40,
              height: 40,
              borderColor: grey,
              leftWidget: Icon(
                Icons.skip_next,
                color: greyDark,
              ),
            ),
          );
  });
}

Widget _previousButton(TunePreviewController cont) {
  return Obx(() {
    return cont.hidePrevious.value
        ? const SizedBox(width: 40)
        : Container(
            decoration: _shadowDecoration(),
            child: CustomButton(
              onTap: () {
                cont.prevousTapped();
              },
              width: 40,
              height: 40,
              borderColor: grey,
              leftWidget: Icon(
                Icons.skip_previous,
                color: greyDark,
              ),
            ),
          );
  });
}

Widget _playButton(TunePreviewController cont) {
  return Obx(() {
    return Container(
      decoration: _shadowDecoration(),
      child: CustomButton(
        onTap: () {
          cont.playTapped();
        },
        borderWidth: 3,
        width: 60,
        height: 60,
        borderColor: grey,
        color: blue,
        leftWidget: Icon(
          cont.isPlaying.value ? Icons.pause : Icons.play_arrow,
          color: white,
          size: 28,
        ),
      ),
    );
  });
}

BoxDecoration _shadowDecoration() {
  return BoxDecoration(boxShadow: [
    BoxShadow(
        blurRadius: 5,
        spreadRadius: 2,
        offset: Offset(0, 2),
        color: black.withOpacity(0.25))
  ], borderRadius: BorderRadius.circular(30), color: white);
}
