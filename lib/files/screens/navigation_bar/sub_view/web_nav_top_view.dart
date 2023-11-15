import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';

class WebNavTopView extends StatelessWidget {
  const WebNavTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOnHover(
      builder: (isHovered) {
        return Container(
          height: 35,
          color: white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [leftWidget(), rightWidget(context)],
            ),
          ),
        );
      },
      hovered: () {
        mainFocusNode.unfocus();
      },
    );
  }

  Widget leftWidget() {
    return const CustomText(
      title: la7innaStr,
      textColor: red,
      fontName: FontName.ztbold,
      fontSize: 18,
    );
  }

  Widget rightWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            aboutButton(),
            horizintalSpace(),
            faqButton(context),
            horizintalSpace(),
          ],
        ),
        languageButtonWidget(context)
      ],
    );
  }

  Widget aboutButton() {
    return CustomButton(
      title: aboutStr.tr,
      fontName: FontName.ztbold,
      fontSize: 14,
      onTap: () {
        print("About tapped");
      },
    );
  }

  Widget languageButtonWidget(BuildContext context) {
    return Row(
      children: [
        englishButton(context),
        horizintalSpace(width: 6),
        customDivider(),
        horizintalSpace(width: 6),
        arabicButton(context)
      ],
    );
  }

  Widget horizintalSpace({double width = 30}) {
    return SizedBox(width: width);
  }

  Widget customDivider() {
    return Container(
      height: 10,
      width: 1,
      color: black,
    );
  }

  Widget englishButton(BuildContext context) {
    return Obx(
      () {
        return CustomButton(
          title: englishStr.tr,
          textColor: appCont.isEnglish.value ? red : black,
          fontName:
              appCont.isEnglish.value ? FontName.ztbold : FontName.ztregular,
          fontSize: 14,
          onTap: () {
            context.go(homeGoRoute);
            print("english tapped");

            StoreManager().setLanguage(isEnglish: true);
            ServiceCall().getAllUrls();
          },
        );
      },
    );
  }

  Widget arabicButton(BuildContext context) {
    return Obx(
      () {
        return CustomButton(
          title: arabicStr.tr,
          textColor: appCont.isEnglish.value ? black : red,
          fontName:
              appCont.isEnglish.value ? FontName.ztregular : FontName.ztbold,
          fontSize: 14,
          onTap: () {
            context.go(homeGoRoute);
            //replaceNamed(homeGoRoute);

            StoreManager().setLanguage(isEnglish: false);
            ServiceCall().getAllUrls();
            print("arabic tapped");
          },
        );
      },
    );
  }

  Widget faqButton(BuildContext context) {
    return CustomButton(
      title: faqStr.tr,
      fontName: FontName.ztbold,
      fontSize: 14,
      onTap: () {
        context.goNamed(faqGoRoute);
        print("faq tapped");
      },
    );
  }
}
