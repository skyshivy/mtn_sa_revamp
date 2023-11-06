import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

Widget tunePreviewTuneInfo(TunePreviewController cont) {
  return Obx(() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            alignment: TextAlign.center,
            title:
                cont.list[cont.index.value].toneName ?? '', //.toneName ?? '',
            fontName: FontName.bold,
            fontSize: 18,
          ),
          CustomText(
            alignment: TextAlign.center,
            title: cont.list[cont.index.value].artistName ??
                '', //info.artistName ?? info.artist ?? '',
            fontName: FontName.medium,
            fontSize: 12,
          )
        ],
      ),
    );
  });
}
