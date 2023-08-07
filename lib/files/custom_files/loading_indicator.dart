import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({double? height = 50, double radius = 25}) {
  return SizedBox(
    height: height,
    child: CupertinoActivityIndicator(
      radius: radius,
    ),
  );
}
