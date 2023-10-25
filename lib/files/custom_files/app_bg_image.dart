import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

Container backgroundImageWidget() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      image: DecorationImage(
        image: const ExactAssetImage(appBgImage),
        fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.2), BlendMode.dstATop),
      ),
    ),
  );
}
