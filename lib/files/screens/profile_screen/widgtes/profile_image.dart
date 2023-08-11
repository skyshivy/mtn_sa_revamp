import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget profileImageWidget() {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: _decoration(),
    height: 120,
    width: 120,
    child: const CustomImage(),
  );
}

BoxDecoration _decoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(blurRadius: 4, spreadRadius: 3, color: black.withOpacity(0.1))
    ],
    borderRadius: BorderRadius.circular(60),
  );
}
