import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

Widget tunePreviewImage(TunePreviewController cont) {
  return Obx(() {
    return CustomImage(
      url: cont.list[cont.index.value].toneIdpreviewImageUrl,
    );
  });
}
