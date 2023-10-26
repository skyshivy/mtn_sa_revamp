import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Widget mobileAppBarLogoButton(BuildContext context) {
  PlayerController con = Get.find();
  AppController appCont = Get.find();
  return Center(
    child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Obx(() {
          return CustomButton(
            color: appCont.index.value != 0 ? transparent : transparent,
            radius: 2,
            onTap: () {
              con.stop();

              if (appCont.index.value == 0) {
                context.go(homeGoRoute);
              } else {
                //window.history.back();
              }

              //Navigator.of(context).maybePop();
            },
            leftWidget: Image.asset(
              (appCont.index.value == 0 ||
                      appCont.index.value == 1 ||
                      appCont.index.value == 2 ||
                      appCont.index.value == 3 ||
                      appCont.index.value == 4)
                  ? atomLogoBigImg
                  : mobileBackImg,
              color: appCont.index.value != 0 ? white : white,
              height: 40,
              width: 40,
            ),
          );
        })),
  );
}
