import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class SeacrhHeaderTab extends StatelessWidget {
  SearchTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return !controller.isLoaded.value
          ? SizedBox()
          : Row(
              children: [
                Expanded(
                    child: customButton(tuneStr, 0, () {
                  controller.isTuneSelected.value = 0;
                })),
                Container(height: 50, width: 1, color: white),
                Expanded(
                    child: customButton(artistStr, 1, () {
                  controller.isTuneSelected.value = 1;
                })),
              ],
            );
    });
  }

  Widget customButton(String title, int index, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        color: yellow,
        child: Center(
            child: CustomText(
          title: title,
          fontName: index == controller.isTuneSelected.value
              ? FontName.bold
              : FontName.regular,
          fontSize: 16,
        )),
      ),
    );
  }
}
