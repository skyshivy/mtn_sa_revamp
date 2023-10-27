import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class WebNavTopView extends StatelessWidget {
  const WebNavTopView({super.key});

  @override
  Widget build(BuildContext context) {
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
        languageButtonWidget()
      ],
    );
  }

  Widget aboutButton() {
    return CustomButton(
      title: aboutStr,
      fontName: FontName.ztbold,
      fontSize: 14,
      onTap: () {
        print("About tapped");
      },
    );
  }

  Widget languageButtonWidget() {
    return Row(
      children: [
        englishButton(),
        horizintalSpace(width: 6),
        customDivider(),
        horizintalSpace(width: 6),
        arabicButton()
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

  Widget englishButton() {
    return Obx(
      () {
        return CustomButton(
          title: englishStr,
          textColor: appCont.isEnglish.value ? red : black,
          fontName:
              appCont.isEnglish.value ? FontName.ztbold : FontName.ztregular,
          fontSize: 14,
          onTap: () {
            print("english tapped");
            StoreManager().setLanguage(true);
          },
        );
      },
    );
  }

  Widget arabicButton() {
    return Obx(
      () {
        return CustomButton(
          title: arabicStr,
          textColor: appCont.isEnglish.value ? black : red,
          fontName:
              appCont.isEnglish.value ? FontName.ztregular : FontName.ztbold,
          fontSize: 14,
          onTap: () {
            StoreManager().setLanguage(false);
            print("arabic tapped");
          },
        );
      },
    );
  }

  Widget faqButton(BuildContext context) {
    return CustomButton(
      title: faqStr,
      fontName: FontName.ztbold,
      fontSize: 14,
      onTap: () {
        context.goNamed(faqGoRoute);
        print("faq tapped");
      },
    );
  }
}
