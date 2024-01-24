import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
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
                        child: row(context),
                      ),
                    ),
                  ],
                );
        });
      },
    );
  }

  Row row(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          leftWidgetPadding: const EdgeInsets.only(right: 10),
          leftWidget: const Icon(Icons.arrow_back),
          onTap: () {
            context.go(homeGoRoute);
          },
        ),
        CustomText(
          title: searchedResultForStr.tr,
          textColor: grey,
        ),
        CustomText(
          title: controller.searchedText.value,
        )
      ],
    );
  }
}
