import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart';
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
      page: () => ArtistTuneScreen(),
    ),
  ];
}
