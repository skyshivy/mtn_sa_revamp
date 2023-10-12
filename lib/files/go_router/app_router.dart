import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/banner_detail_controller/banner_detail_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/artist_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/home_banner_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/profile_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/see_more_screen/see_more_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/sub_views/home_banner_detail_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/screens/wishlist_screen/wishlsit_screen.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: homeGoRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: shellRouteIndex,
      branches: [
        homeScreen(),
        faqScreen(),
        categoryDetailScreen(),
        searchScreen(),
        artistTuneDetailScreen(),
        bannerDetailScreen(),
        seeMoreScreen(),
        profileScreen(),
        wishlistScreen(),
        myTuneScreen(),
      ],
    ),
  ],
);

StatefulShellBranch artistTuneDetailScreen() {
  ArtistController artCont = Get.put(ArtistController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: artistGoRoute,
      path: artistGoRoute,
      builder: (context, state) {
        print(
            "pathParameters is ===== ${state.uri.queryParameters['categoryName']}");
        String artistName = state.uri.queryParameters['artist'] ?? '';
        artCont.getArtistSongs(artistName);
        return ArtistTuneScreen(artistName: artistName);
      },
    ),
  ]);
}

StatefulShellBranch bannerDetailScreen() {
  BannerDetailController bannerCont = Get.put(BannerDetailController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: bannerGoRoute,
      path: bannerGoRoute,
      builder: (context, state) {
        String bannerOrder = state.uri.queryParameters['bannerOrder'] ?? '';
        String type = state.pathParameters['type'] ?? '';
        String searchKey = state.uri.queryParameters['searchKey'] ?? '';
        bannerCont.getDetail(bannerOrder, searchKey);
        return HomeBannerDetailPage(
            type: type, bannerOrder: bannerOrder, searchKey: searchKey);
      },
    ),
  ]);
}

StatefulShellBranch profileScreen() {
  ProfileController pCont = Get.put(ProfileController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: profileGoRoute,
      path: profileGoRoute,
      builder: (context, state) {
        return ProfileScreen();
      },
    ),
  ]);
}

StatefulShellBranch wishlistScreen() {
  WishlistController wCont = Get.put(WishlistController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: wishlistGoRoute,
      path: wishlistGoRoute,
      builder: (context, state) {
        return WishlistScreen();
      },
    ),
  ]);
}

StatefulShellBranch myTuneScreen() {
  MyTuneController myTuneController = Get.put(MyTuneController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: myTuneGoRoute,
      path: myTuneGoRoute,
      builder: (context, state) {
        return MyTuneScreen();
      },
    ),
  ]);
}

StatefulShellBranch seeMoreScreen() {
  BannerDetailController bannerCont = Get.put(BannerDetailController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: moreGoRoute,
      path: moreGoRoute,
      builder: (context, state) {
        List<TuneInfo>? list = state.extra as List<TuneInfo>;
        //print("List is =========== $list");
        if (list.isEmpty) {
          context.go(homeGoRoute);
          return WebLandingPage();
        }
        return SeeMoreScreen();
      },
    ),
  ]);
}

StatefulShellBranch categoryDetailScreen() {
  CategoryController catCont = Get.find();
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: tuneGoRoute,
      path: tuneGoRoute,
      builder: (context, state) {
        print(
            "pathParameters is ===== ${state.uri.queryParameters['categoryName']}");
        String categoryName = state.uri.queryParameters['categoryName'] ?? '';
        String categoryId = state.uri.queryParameters['categoryId'] ?? '';
        CategoryScreen catScreen =
            CategoryScreen(category: categoryName, id: categoryId);
        catCont.getCategroyDetail(categoryName, categoryId);
        return catScreen;
      },
    ),
  ]);
}

StatefulShellBranch faqScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      path: faqGoRoute,
      builder: (context, state) {
        return FAQScreen();
      },
    ),
  ]);
}

StatefulShellBranch searchScreen() {
  SearchTuneController sCOnt = Get.find();
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: searchGoRoute,
      path: searchGoRoute,
      builder: (context, state) {
        String searchkey = state.uri.queryParameters['key'] ?? '';
        sCOnt.getSearchedResult(searchkey, 0);
        return SearchScreen(); //CustomText(title: "title  $searchkey");
      },
    ),
  ]);
}

StatefulShellBranch homeScreen() {
  return StatefulShellBranch(
    navigatorKey: _sectionNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
          path: homeGoRoute,
          builder: (context, state) {
            return WebLandingPage();
          }),
    ],
  );
}

StatefulShellBranch artistTuneScreen() {
  return StatefulShellBranch(
    navigatorKey: _sectionNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
          name: artistGoRoute,
          path: artistGoRoute,
          builder: (context, state) {
            String artist = state.uri.queryParameters['artist'] ?? '';
            print("we are ate $artist");
            //
            return CustomText(title: "sdfsdfsdfsdfs");
            // ArtistTuneScreen(
            //   artistName: artist,
            // );
          }),
    ],
  );
}

Widget shellRouteIndex(context, state, navigationShell) {
  print("Selected index must be===== ${navigationShell.currentIndex}");

  return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: Column(
          children: [
            WebNavBarView(navigationShell: navigationShell),
            Expanded(child: navigationShell)
          ],
        ),
      ));
}
