import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileTuneStatus extends StatelessWidget {
  ProfileController cont = Get.find();
  ProfileTuneStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Container(
          decoration: contanerDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                firstRowWidget(sizingInformation),
                const SizedBox(height: 5),
                Obx(() {
                  return CustomText(
                    title: expireDateStr + " : " + cont.tuneExire.value,
                    fontName: FontName.medium,
                    fontSize: 14,
                  ); //expireDateStr + " : " + '12/10/23'),
                }),
                const SizedBox(height: 15),
                secondRowWidget(sizingInformation),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget firstRowWidget(SizingInformation si) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: si.isMobile ? MainAxisSize.max : MainAxisSize.min,
      children: [
        const CustomText(
          title: myTuneStatusStr,
          fontName: FontName.medium,
          fontSize: 14,
        ),
        Obx(() {
          return CustomText(
            title: " : " + cont.tuneStatus.value,
            fontName: FontName.medium,
            fontSize: 14,
          );
        }),
      ],
    );
  }

  Widget secondRowWidget(SizingInformation si) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: si.isMobile ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Obx(() {
          return CustomButton(
            height: 35,
            fontName: FontName.medium,
            fontSize: 12,
            titlePadding: const EdgeInsets.symmetric(horizontal: 12),
            title: cont.activeTuneButtonName.value,
            textColor: white,
            color: blue,
            onTap: () {
              if (cont.activeTuneButtonName.value == activeStr) {
                cont.activeTuneStatusAction();
              } else {
                cont.suspendTuneStatusAction();
              }
            },
          );
        }),
        SizedBox(width: 20),
        CustomButton(
          fontName: FontName.medium,
          fontSize: 12,
          height: 35,
          titlePadding: EdgeInsets.symmetric(horizontal: 12),
          title: unSubscribeStr,
          textColor: white,
          color: blue,
          onTap: () {
            cont.unsubscribeTuneStatusAction();
          },
        ),
      ],
    );
  }

  BoxDecoration contanerDecoration() {
    return BoxDecoration(
        color: grey, borderRadius: BorderRadiusDirectional.circular(8));
  }
}
