import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileReverseRbtStatus extends StatelessWidget {
  ProfileReverseRbtStatus({super.key});
  ProfileController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          decoration: contanerDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                firstRowWidget(si),
                const SizedBox(height: 5),
                Obx(() {
                  return CustomText(
                    title: expireDateStr + " : " + cont.rrbtExpire.value,
                    fontName: FontName.medium,
                    fontSize: 14,
                  );
                }),
                const SizedBox(height: 15),
                secondRowWidget(si),
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
        CustomText(
          title: reverseRBTStatusStr,
          fontName: FontName.medium,
          fontSize: 14,
        ),
        Obx(() {
          return CustomText(
            title: ' : ' + cont.rrbtStatus.value,
            fontName: FontName.medium,
            fontSize: 14,
          );
        })
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
              titlePadding: const EdgeInsets.symmetric(horizontal: 12),
              title: cont.activeRrbtButtonName.value,
              textColor: white,
              color: blue,
              fontName: FontName.medium,
              fontSize: 12,
              onTap: () {
                if (cont.activeRrbtButtonName.value == activeStr) {
                  cont.activeRrbtStatusAction();
                } else {
                  cont.suspendRrbtStatusAction();
                }
              });
        }),
        SizedBox(width: 20),
        CustomButton(
          height: 35,
          titlePadding: EdgeInsets.symmetric(horizontal: 12),
          title: unSubscribeStr,
          textColor: white,
          color: blue,
          fontName: FontName.medium,
          fontSize: 12,
          onTap: () {
            cont.unSubscribeRrbtStatusAction();
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