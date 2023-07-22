import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';

List<GetPage<dynamic>> get routesDirection {
  return [
    GetPage(
        transitionDuration: Duration(milliseconds: 1),
        name: '/',
        page: () => Container(
              color: red,
            )),
    GetPage(
        transitionDuration: Duration(milliseconds: 1),
        name: artistTuneRoute,
        page: () => Container(
              color: yellow,
            )),
  ];
}
