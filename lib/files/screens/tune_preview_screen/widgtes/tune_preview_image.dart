import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';

Widget tunePreviewImage(TunePreviewController cont) {
  return Obx(() {
    return customImage(
      url: cont.list[cont.index.value].toneIdpreviewImageUrl,
    );
  });
}
