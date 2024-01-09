import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
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
import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/localization/localizatio_service.dart';
import 'package:mtn_sa_revamp/files/model/home_banner_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart';
import 'package:mtn_sa_revamp/files/screens/delete_screen/delete_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/help_screen/help_screen.dart';
import 'package:mtn_sa_revamp/files/screens/history_screen/history_screen.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/screens/music_pack_screen/music_pack_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_bar.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/profile_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/see_more_screen/see_more_screen.dart';
import 'package:mtn_sa_revamp/files/screens/terms_condition/terms_condition_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/sub_views/home_banner_detail_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/screens/wishlist_screen/wishlsit_screen.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/main.dart';
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
        musicPackScreenRoute(),
        //deleteScreenRoute(),
        historyScreenRoute(),
        _privatePolicyScreen(),
        _helpScreen(),
        _termsScreen(),
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
        printCustom(
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
        String type = state.uri.queryParameters['type'] ?? '';
        String searchKey = state.uri.queryParameters['searchKey'] ?? '';
        bannerCont.getDetail(type, bannerOrder, searchKey);
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
        return const ProfileScreen();
      },
    ),
  ]);
}

StatefulShellBranch _privatePolicyScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: policyGoRoute,
      path: policyGoRoute,
      builder: (context, state) {
        //pCont.getProfileDetail();
        return const PrivacyPolicyScreen();
      },
    ),
  ]);
}

StatefulShellBranch _helpScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: helpGoRoute,
      path: helpGoRoute,
      builder: (context, state) {
        //pCont.getProfileDetail();
        return HelpScreen();
      },
    ),
  ]);
}

StatefulShellBranch _termsScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: termsGoRoute,
      path: termsGoRoute,
      builder: (context, state) {
        //pCont.getProfileDetail();
        return TermsConditionScreen();
      },
    ),
  ]);
}

StatefulShellBranch wishlistScreen() {
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
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: myTuneGoRoute,
      path: myTuneGoRoute,
      builder: (context, state) {
        // myTuneController.getPlayingTuneList();
        return MyTuneScreen();
      },
    ),
  ]);
}

StatefulShellBranch historyScreenRoute() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: historyGoRoute,
      path: historyGoRoute,
      builder: (context, state) {
        return HistoryScreen();
      },
    ),
  ]);
}

StatefulShellBranch seeMoreScreen() {
  BannerDetailController bannerCont = Get.put(BannerDetailController());
  keyScrollFocusNode = FocusNode();
  keyScrollFocusNode.requestFocus();
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: moreGoRoute,
      path: moreGoRoute,
      builder: (context, state) {
        List<TuneInfo>? list = state.extra as List<TuneInfo>;
        //customPrint("List is =========== $list");
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
        printCustom(
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
        String index = state.uri.queryParameters['index'] ?? "0";
        sCOnt.stopMultipleApiCall = true;
        sCOnt.getSearchedResult(searchkey, 0,
            searchTypeIndex: int.parse(index));

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

StatefulShellBranch musicPackScreenRoute() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: musicPackGoRoute,
      path: musicPackGoRoute,
      builder: (context, state) {
        return MusicPackScreen(); //CustomText(title: "title  $searchkey");
      },
    ),
  ]);
}

Widget askForLoginScreen() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomText(
            alignment: TextAlign.center,
            title: featureIsAvailableForLoggedInStr,
            fontName: FontName.bold,
            fontSize: 20,
          ),
          const SizedBox(height: 20),
          CustomButton(
            textColor: white,
            title: loginStr.tr,
            color: blue,
            fontName: FontName.bold,
            fontSize: 16,
            width: 200,
            onTap: () {
              StoreManager().checkStoredValue();
              Get.dialog(const LoginScreen(), barrierDismissible: false);
            },
          )
        ],
      ),
    ),
  );
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

Widget shellRouteIndex(BuildContext context, GoRouterState state,
    StatefulNavigationShell navigationShell) {
  printCustom("Selected index must be===== ${navigationShell.currentIndex}");
  if (state.fullPath == profileGoRoute) {
    ProfileController con = Get.find();
    con.getProfileDetail();
  }
  if (state.fullPath == myTuneGoRoute) {
    MyTuneController con = Get.find();
    con.getPlayingTuneList();
  }
  printCustom("SKY state.name  = ${state.fullPath}");

  printCustom("SKY StoreManager().isLoggedIn  = ${StoreManager().isLoggedIn}");
  goRouterContext = context;
  var pat = state.fullPath;
  var pat1 = historyGoRoute;
  var pat2 = profileGoRoute;
  var pat3 = wishlistGoRoute;
  var pat4 = myTuneGoRoute;
  var pat5 = myTuneSettingGoRoute;

  print("is this transaction ${pat == pat1} ");

  appCont.updateIndex(navigationShell.currentIndex);
  bool isLoad = true;

  if ((pat == pat1) ||
      (pat == pat2) ||
      (pat == pat3) ||
      (pat == pat4) ||
      (pat == pat5)) {
    isLoad = StoreManager().isLoggedIn;
  }
  MtnAudioPlayer.instance.stop();
  printCustom("ccid = $ccid");
  return GetMaterialApp(
    locale: Locale(StoreManager().isEnglish ? 'en' : 'br',
        StoreManager().isEnglish ? 'US' : 'BR'),
    fallbackLocale: const Locale('en', 'US'),
    translations: LocalizationService(),
    debugShowCheckedModeBanner: false,
    title: "Atom",
    home: ResponsiveBuilder(
      builder: (context, si) {
        keyScrollFocusNode.requestFocus();
        return Material(
          child: Column(
            children: [
              si.isMobile
                  ? const SizedBox()
                  : WebNavBarView(navigationShell: navigationShell),
              si.isMobile
                  ? Expanded(
                      child: MobileAppBar(
                          widget:
                              isLoad ? navigationShell : askForLoginScreen()))
                  : Expanded(
                      child: isLoad ? navigationShell : askForLoginScreen())
            ],
          ),
        );
      },
    ),
  );
}
