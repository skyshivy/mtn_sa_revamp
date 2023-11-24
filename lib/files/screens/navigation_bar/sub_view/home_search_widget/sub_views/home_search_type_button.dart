import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeSearchTypeButton extends StatelessWidget {
  final SearchTuneController sCont = Get.find();

  HomeSearchTypeButton({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            radioButton(songStr, 0, si),
            const SizedBox(width: 40),
            radioButton(singerStr, 1, si),
            const SizedBox(width: 40),
            radioButton(codeStr, 2, si),
          ],
        );
      },
    );
  }

  Widget radioButton(String title, int index, SizingInformation si) {
    return InkWell(
      onTap: () {
        print("object");
        sCont.updateSearchType(index);
      },
      child: SizedBox(
          height: 40,
          child: Obx(() {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  color: (index == sCont.searchType.value) ? red : white,
                  size: si.isMobile ? 18 : 20,
                ),
                const SizedBox(width: 4),
                CustomText(
                  title: title,
                  textColor: (index == sCont.searchType.value) ? red : white,
                  fontName: si.isMobile
                      ? FontName.medium
                      : FontName.bold, //si.isMobile ?  18:20,
                  fontSize: si.isMobile ? 14 : 16,
                )
              ],
            );
          })),
    );
  }
}
