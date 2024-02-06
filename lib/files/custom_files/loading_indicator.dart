import 'package:flutter/cupertino.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget loadingIndicator(
    {Color color = black, double? height = 50, double radius = 25}) {
  return SizedBox(
    height: height,
    child: CupertinoActivityIndicator(
      radius: radius,
      color: color,
    ),
  );
}
