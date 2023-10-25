import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomAlertView extends StatelessWidget {
  final String title;
  final String btnName;
  final double width;
  final Function()? onConfirm;
  final Color color;
  CustomAlertView({
    super.key,
    this.onConfirm,
    this.width = 400,
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
        child: Center(child: mainContainer()),
      ),
    );
  }

  Widget mainContainer() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          clipBehavior: Clip.hardEdge,
          //height: 200,
          width: si.isMobile ? MediaQuery.of(context).size.width - 60 : 400,
          decoration: mainContainerDecoration(),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: mainColumn(),
          ),
        );
      },
    );
  }

  Column mainColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          alignment: TextAlign.center,
          title: title,
          fontName: FontName.abook,
        ),
        const SizedBox(height: 20),
        CustomButton(
            borderColor: greyDark,
            width: 120,
            title: okStr,
            fontName: FontName.ztregular,
            onTap: () {
              //Get.back();

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
