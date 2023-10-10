import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: homeRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: shellRouteIndex,
      branches: [
        homeScreen(),
        faqScreen(),
        categoryDetailScreen(),
        searchScreen(),
      ],
    ),
  ],
);

StatefulShellBranch categoryDetailScreen() {
  CategoryController catCont = Get.find();
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: tuneRoute,
      path: tuneRoute,
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
      path: faqRoute,
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
      name: searchRoute,
      path: searchRoute,
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
          path: homeRoute,
          builder: (context, state) {
            return WebLandingPage();
          }),
    ],
  );
}

Widget shellRouteIndex(context, state, navigationShell) {
  print("Selected index must be===== ${navigationShell.currentIndex}");

  return GetMaterialApp(
      home: Material(
    child: Column(
      children: [
        WebNavBarView(navigationShell: navigationShell),
        Expanded(child: navigationShell)
      ],
    ),
  ));
}
