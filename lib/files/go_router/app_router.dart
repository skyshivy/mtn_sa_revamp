import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/artist_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/home_banner_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';

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
  ArtistController artCont = Get.put(ArtistController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: bannerGoRoute,
      path: bannerGoRoute,
      builder: (context, state) {
        String? bannerOrkder = state.uri.queryParameters['bannerOrder'];
        String? type = state.uri.queryParameters['type'];
        String? searchKey = state.uri.queryParameters['searchKey'];

        return Text(
            "Banner ${bannerOrkder}  \n ${searchKey}  \n ${type}"); //Bannerscr(artistName: artistName);
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
