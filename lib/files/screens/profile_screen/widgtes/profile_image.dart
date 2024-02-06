import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

Widget profileImageWidget() {
  return Container(
      clipBehavior: Clip.hardEdge,
      decoration: _decoration(),
      height: 120,
      width: 120,
      child: const Icon(
        Icons.person,
        size: 80,
      ) //const CustomImage(),
      );
}

BoxDecoration _decoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 4,
        color: black.withOpacity(0.1),
      )
    ],
    color: white,
    borderRadius: BorderRadius.circular(60),
  );
}
