import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class SettingCell extends StatelessWidget {
  final String name;
  final int index;
  const SettingCell({super.key, required this.name, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.white,
      child: Column(
        children: [_settingcell(context, index), horizintalDevider()],
      ),
    );
  }

  Expanded _settingcell(BuildContext context, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print("Tapped ");
          navigateToPage(name, index, context);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomText(
                title: name,
                fontName: FontName.ztregular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget horizintalDevider() {
    return Container(
      height: 1,
      color: greyLight,
    );
  }
}

navigateToPage(String name, int index, BuildContext context) {
  if (index == 0) {
    context.pushNamed(profileGoRoute);
  } else if (index == 1) {
    context.pushNamed(myTuneGoRoute);
  } else if (index == 2) {
    context.pushNamed(wishlistGoRoute);
  } else if (index == 3) {
    context.pushNamed(historyGoRoute);
  } else if (index == 4) {
    context.pushNamed(faqGoRoute);
  } else if (index == 5) {
  } else if (index == 6) {
  } else if (index == 7) {
  } else if (index == 8) {
  } else if (index == 9) {}
}
