import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileCrbtTuneStatus extends StatelessWidget {
  final ProfileController cont = Get.find();
  ProfileCrbtTuneStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Visibility(
          visible: !cont.isHideCRBTStatus.value,
          child: ResponsiveBuilder(
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
                        return cont.tuneExire.isEmpty
                            ? const SizedBox()
                            : CustomText(
                                title:
                                    "${expireDateStr.tr} : ${cont.tuneExire.value}",
                                fontName: FontName.medium,
                                fontSize: 14,
                              ); //expireDateStr.tr + " : " + '12/10/23'),
                      }),
                      const SizedBox(height: 4),
                      Obx(() {
                        return CustomText(
                          title: cont.crbtTuneStatusMessage.value,
                          fontName: FontName.medium,
                          fontSize: 14,
                        );
                      }),
                      const SizedBox(height: 15),
                      buttonaRow(sizingInformation),
                    ],
                  ),
                ),
              );
            },
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
          title: myTuneStatusStr.tr,
          fontName: FontName.medium,
          fontSize: 14,
        ),
        Obx(() {
          return CustomText(
            title: " : " + cont.crbtTuneStatus.value,
            fontName: FontName.medium,
            fontSize: 14,
          );
        }),
      ],
    );
  }

  Widget buttonaRow(SizingInformation si) {
    return Obx(() {
      return cont.isUpdatingCrbtStatus.value
          ? loadingInd()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: si.isMobile ? MainAxisSize.max : MainAxisSize.min,
              children: [
                Obx(() {
                  return activeSuspendButton();
                }),
                SizedBox(width: 20),
                unsubscribeButton(),
              ],
            );
    });
  }

  Widget unsubscribeButton() {
    return Obx(() {
      return cont.isUpdatingCrbtStatus.value
          ? loadingInd()
          : CustomButton(
              fontName: FontName.medium,
              fontSize: 12,
              height: 35,
              titlePadding: EdgeInsets.symmetric(horizontal: 12),
              title: cont.crbtSubscriptionButtonName.value,
              textColor: white,
              color: blue,
              onTap: () {
                cont.unsubscribeCrbtTuneStatusAction();
              },
            );
    });
  }

  CustomButton activeSuspendButton() {
    return CustomButton(
      height: 35,
      fontName: FontName.medium,
      fontSize: 12,
      titlePadding: const EdgeInsets.symmetric(horizontal: 12),
      title: cont.activeCrbtButtonName.value,
      textColor: white,
      color: blue,
      onTap: () {
        if (cont.activeCrbtButtonName.value == suspendStr.tr) {
          cont.activeCrbtStatusAction();
        } else {
          cont.suspendCrbtStatusAction();
        }
      },
    );
  }

  Widget loadingInd() {
    return SizedBox(
        width: 200, child: loadingIndicator(height: 35, radius: 10));
  }

  BoxDecoration contanerDecoration() {
    return BoxDecoration(
        color: grey, borderRadius: BorderRadiusDirectional.circular(8));
  }
}
