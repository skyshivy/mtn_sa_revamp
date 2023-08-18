import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_bar.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/profile_screen.dart';
import 'package:mtn_sa_revamp/files/screens/wishlist_screen/wishlsit_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/sub_views/home_banner_detail_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<GetPage<dynamic>> get routesDirection {
  Duration dur = const Duration(milliseconds: 1);
  PlayerController controller = Get.find();
  Widget reteurnWidget(Widget widget) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile ? MobileAppBar(widget: widget) : widget;
      },
    );
  }

  return [
    GetPage(
        transitionDuration: dur,
        name: '/',
        page: () => Container(
              color: red,
            )),
    GetPage(
      transitionDuration: dur,
      name: artistTuneRoute,
      page: () {
        String artist = Get.parameters['artist'] ?? '';
        controller.stop();
        return Material(
          child: reteurnWidget(ArtistTuneScreen(
            artistName: artist,
          )),
        );
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: profileTapped,
      page: () {
        controller.stop();
        return Material(child: reteurnWidget(ProfileScreen()));
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: wishlistTapped,
      page: () {
        controller.stop();
        return Material(child: reteurnWidget(WishlistScreen()));
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: myTuneTapped,
      page: () {
        controller.stop();
        return Material(child: MyTuneScreen());
      },
    ),
    GetPage(
      name: myTuneSettingTapped,
      page: () {
        controller.stop();
        String toneId = Get.parameters['toneId'] ?? '';
        String toneName = Get.parameters['toneName'] ?? '';
        String toneArtist = Get.parameters['toneArtist'] ?? '';
        String toneImage = Get.parameters['toneImage'] ?? '';
        return Material(
            child: reteurnWidget(MyTuneSettingScreen(
          toneId: toneId,
          toneName: toneName,
          toneArtist: toneArtist,
          toneImage: toneImage,
        )));
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: tuneCatTapped,
      page: () {
        controller.stop();
        String categoryName = Get.parameters['categoryName'] ?? '';
        String categoryId = Get.parameters['categoryId'] ?? '';
        return Material(
            child: reteurnWidget(
                CategoryScreen(category: categoryName, id: categoryId)));
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: bannerTapped,
      page: () {
        controller.stop();
        String searchKey = Get.parameters['searchKey'] ?? '';
        String bannerOrder = Get.parameters['bannerOrder'] ?? '';
        String type = Get.parameters['type'] ?? '';
        return Material(
            child: reteurnWidget(HomeBannerDetailPage(
                type: type, bannerOrder: bannerOrder, searchKey: searchKey)));
      },
    ),
    GetPage(
      transitionDuration: dur,
      name: loginTapped,
      page: () => Container(
        color: white,
        child: Center(child: CustomText(title: "Test here")),
      ),
    ),
  ];
}
