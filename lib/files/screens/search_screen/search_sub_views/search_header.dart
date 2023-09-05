import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchHeader extends StatelessWidget {
  SearchTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return !controller.isLoaded.value
              ? SizedBox()
              : Row(
                  children: [
                    Container(
                      height: si.isMobile ? 40 : 50,
                      child: Center(
                        child: row(),
                      ),
                    ),
                  ],
                );
        });
      },
    );
  }

  Row row() {
    return Row(
      children: [
        const CustomText(
          title: searchedResultForStr,
          textColor: grey,
        ),
        CustomText(
          title: controller.searchedText.value,
        )
      ],
    );
  }
}
