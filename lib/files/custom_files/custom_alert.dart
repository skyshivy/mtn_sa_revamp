import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class CustomAlertView extends StatelessWidget {
  final String title;
  final String btnName;
  final Function()? onConfirm;
  final Color color;
  CustomAlertView({
    super.key,
    this.onConfirm,
    this.color = white,
    required this.title,
    this.btnName = okStr,
  });
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Center(
      child: Material(
        color: transparent,
        child: mainContainer(),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 200,
      width: 400,
      decoration: mainContainerDecoration(),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child: mainColumn(),
      ),
    );
  }

  Column mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          alignment: TextAlign.center,
          title: title,
          fontName: FontName.regular,
        ),
        const SizedBox(height: 20),
        CustomButton(
            borderColor: greyDark,
            width: 120,
            title: okStr,
            fontName: FontName.medium,
            onTap: () {
              Get.back();

              Navigator.pop(context);
              onConfirm!();
            })
      ],
    );
  }

  BoxDecoration mainContainerDecoration() {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
