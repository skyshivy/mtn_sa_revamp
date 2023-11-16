import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileReverseRbtStatus extends StatelessWidget {
  const ProfileReverseRbtStatus({super.key});

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
                SizedBox(height: 20),
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
        CustomText(title: myTuneStatusStr),
        CustomText(title: ' : ' + suspendStr),
      ],
    );
  }

  Widget secondRowWidget(SizingInformation si) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: si.isMobile ? MainAxisSize.max : MainAxisSize.min,
      children: [
        CustomButton(
          height: 35,
          titlePadding: EdgeInsets.symmetric(horizontal: 12),
          title: activeStr,
          textColor: white,
          color: blue,
        ),
        SizedBox(width: 20),
        CustomButton(
          height: 35,
          titlePadding: EdgeInsets.symmetric(horizontal: 12),
          title: unSubscribeStr,
          textColor: white,
          color: blue,
        ),
      ],
    );
  }

  BoxDecoration contanerDecoration() {
    return BoxDecoration(
        color: grey, borderRadius: BorderRadiusDirectional.circular(8));
  }
}
