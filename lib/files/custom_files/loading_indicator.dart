import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator({double radius = 25}) {
  return CupertinoActivityIndicator(
    radius: radius,
  );
}
