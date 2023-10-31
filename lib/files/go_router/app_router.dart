import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/banner_detail_controller/banner_detail_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/faq_controller/faq_controller.dart';

import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/artist_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/home_banner_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/delete_screen/delete_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_bar.dart';
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
import 'package:responsive_builder/responsive_builder.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();
AppController appCont = Get.find();
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
        tuneSettingScreen(),
        deleteScreenRoute(),
        //openMyTuneSettingScreen(),
        //newSceen(),
      ],
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(child: errorWidget(context, state));
  },
);

Widget errorWidget(BuildContext context, GoRouterState state) {
  return Scaffold(
      body: MobileAppBar(
    widget: const Center(
      child: CustomText(
        title: "Page Not Found",
        fontName: FontName.bold,
        fontSize: 20,
      ),
    ),
  ));
}

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
        //pCont.getProfileDetail();
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
        myTuneController.getPlayingTuneList();
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
  FaqController faqCont = Get.put(FaqController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: faqGoRoute,
      path: faqGoRoute,
      builder: (context, state) {
        return FAQScreen();
      },
    ),
  ]);
}

StatefulShellBranch tuneSettingScreen() {
  TuneSettingController cont = Get.put(TuneSettingController());
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: myTuneSettingGoRoute,
      path: myTuneSettingGoRoute,
      builder: (context, state) {
        String toneId = state.uri.queryParameters['toneId'] ?? '';
        String toneName = state.uri.queryParameters['toneName'] ?? '';
        String toneArtist = state.uri.queryParameters['toneArtist'] ?? '';
        String toneImage = state.uri.queryParameters['toneImage'] ?? '';

        return MyTuneSettingScreen(
          toneId: toneId,
          toneName: toneName,
          toneArtist: toneArtist,
          toneImage: toneImage,
        );
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
        return const SearchScreen(); //CustomText(title: "title  $searchkey");
      },
    ),
  ]);
}

StatefulShellBranch deleteScreenRoute() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: deleteGoRoute,
      path: deleteGoRoute,
      builder: (context, state) {
        return DeleteScreen(); //CustomText(title: "title  $searchkey");
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
  appCont.updateIndex(navigationShell.currentIndex);
  return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveBuilder(
        builder: (context, si) {
          return Material(
            child: Column(
              children: [
                si.isMobile
                    ? const SizedBox()
                    : WebNavBarView(navigationShell: navigationShell),
                si.isMobile
                    ? Expanded(child: MobileAppBar(widget: navigationShell))
                    : Expanded(child: navigationShell)
              ],
            ),
          );
        },
      ));
}
