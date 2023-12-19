import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DiyInfo extends StatelessWidget {
  const DiyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizeInfo) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: sizeInfo.isMobile
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              CustomText(
                title: doItYourStr,
                fontSize: sizeInfo.isMobile ? 18 : 38,
                fontName: FontName.aheavy,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                alignment:
                    sizeInfo.isMobile ? TextAlign.left : TextAlign.center,
                title:
                    'Share your own song or audio message with your callers before you pick up the phone.${sizeInfo.isMobile ? '' : "\n"} This is Caller Tunes Karaoke. Record, Upload & Play',
                fontSize: sizeInfo.isMobile ? 14 : 14,
                fontName: FontName.aheavy,
              ),
            ],
          ),
        );
      },
    );
  }
}
