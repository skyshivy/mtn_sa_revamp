import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeacrhHeaderTab extends StatelessWidget {
  SearchTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return !controller.isLoaded.value
              ? SizedBox()
              : Row(
                  children: [
                    Expanded(
                        child: customButton(tuneStr, 0, () {
                      controller.isTuneSelected.value = 0;
                    })),
                    Container(
                        height: si.isMobile ? 40 : 50, width: 1, color: white),
                    Expanded(
                        child: customButton(artistStr, 1, () {
                      controller.isTuneSelected.value = 1;
                    })),
                  ],
                );
        });
      },
    );
  }

  Widget customButton(String title, int index, Function() onTap) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return InkWell(
          onTap: onTap,
          child: Container(
            height: si.isMobile ? 40 : 50,
            color: atomCryan,
            child: Center(
                child: CustomText(
              textColor:
                  index == controller.isTuneSelected.value ? blue : white,
              title: title,
              fontName: index == controller.isTuneSelected.value
                  ? FontName.bold
                  : FontName.medium,
              fontSize: 16,
            )),
          ),
        );
      },
    );
  }
}
