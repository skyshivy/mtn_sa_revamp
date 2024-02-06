import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget mobileAppBarLogoButton(BuildContext context) {
  AppController appCont = Get.find();
  return Center(
    child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Obx(() {
          return CustomButton(
            color: appCont.index.value != 0 ? transparent : white,
            radius: 2,
            onTap: () {
              playerController.stop();

              if (appCont.index.value == 0) {
                context.go(homeGoRoute);
              } else {
                window.history.back();
              }

              //Navigator.of(context).maybePop();
            },
            leftWidget: ResponsiveBuilder(
              builder: (context, si) {
                return Center(
                  child: Image.asset(
                    appCont.index.value != 0
                        ? mobileBackImg
                        : si.isMobile
                            ? atomLogoIcon
                            : atomLogoBigImg,
                    color: appCont.index.value != 0 ? white : null,
                    height: 25,
                    width: 25,
                  ),
                );
              },
            ),
          );
        })),
  );
}
