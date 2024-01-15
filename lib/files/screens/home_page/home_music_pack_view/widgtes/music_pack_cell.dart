import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget musicPackCell(String img, String info, int index) {
  print("index = ${index % 2}");
  return ResponsiveBuilder(
    builder: (context, si) {
      return InkWell(
        onTap: () {
          context.goNamed(musicPackGoRoute);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (si.isDesktop) ? 120 : 12),
          child: si.isMobile
              ? _mobileCell(img, info, si, isOnTop: (index % 2) == 0)
              : _deskTopCell(img, info, si, isLeft: (index % 2) == 0),
        ),
      );
    },
  );
}

Widget _mobileCell(String img, String info, SizingInformation si,
    {bool isOnTop = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      isOnTop ? infoText(info, si) : const SizedBox(),
      Flexible(child: SizedBox(height: 300, child: Image.asset(img))),
      isOnTop ? const SizedBox() : infoText(info, si),
    ],
  );
}

Widget infoText(String info, SizingInformation si) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        title: musicPackStr,
        fontName: FontName.bold,
        fontSize: si.isMobile ? 35 : 45,
      ),
      CustomText(
        title: madeWithStr,
        fontName: FontName.bold,
        fontSize: si.isMobile ? 18 : 25,
      ),
      CustomText(
        title: info,
        fontSize: si.isMobile ? 15 : 18,
      ),
    ],
  );
}

Widget _deskTopCell(String img, String info, SizingInformation si,
    {bool isLeft = true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      isLeft ? Flexible(child: infoText(info, si)) : SizedBox(),
      SizedBox(width: 300, child: Image.asset(img)),
      isLeft ? SizedBox() : Flexible(child: infoText(info, si)),
    ],
  );
}
