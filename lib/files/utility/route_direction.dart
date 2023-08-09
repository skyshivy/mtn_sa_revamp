import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
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
      page: () {
        String artist = Get.parameters['artist'] ?? '';

        return Material(
          child: ArtistTuneScreen(
            artistName: artist,
          ),
        );
      },
    ),
    GetPage(
      transitionDuration: Duration(milliseconds: 1),
      name: tuneCatTapped,
      page: () {
        String categoryName = Get.parameters['categoryName'] ?? '';

        return Material(
          child: Container(
            child: CustomText(title: categoryName),
          ),
        );
      },
    ),
    GetPage(
      transitionDuration: Duration(milliseconds: 1),
      name: loginTapped,
      page: () => Container(
        color: white,
        child: Center(child: CustomText(title: "Test here")),
      ),
    ),
  ];
}
