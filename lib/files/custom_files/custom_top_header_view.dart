import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomTopHeaderView extends StatelessWidget {
  final String title;

  const CustomTopHeaderView({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
            height: si.isMobile ? 40 : 50,
            color: greyLight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
              child: Row(
                children: [
                  const CustomText(
                    title: homeStr,
                    fontName: FontName.ztregular,
                    textColor: grey,
                  ),
                  const CustomText(title: "/"),
                  CustomText(title: title, fontName: FontName.ztregular)
                ],
              ),
            ));
      },
    );
  }
}
