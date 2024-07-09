import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/banner_detail_controller/banner_detail_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/faq_controller/faq_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_detail_controller.dart';

import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/artist_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/new_search_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/audio_palyer/mtn_audio_player.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/localization/localizatio_service.dart';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_screen.dart'
    deferred as def_cat_screen;
import 'package:mtn_sa_revamp/files/screens/delete_screen/delete_screen.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart'
    deferred as def_faq_screen;
import 'package:mtn_sa_revamp/files/screens/help_screen/help_screen.dart'
    deferred as def_help;
import 'package:mtn_sa_revamp/files/screens/history_screen/history_screen.dart'
    deferred as def_history_screen;
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/screens/music_pack_screen/music_pack_detail_list_screen/music_detail_list_screen.dart'
    deferred as def_music_detail;
import 'package:mtn_sa_revamp/files/screens/music_pack_screen/music_pack_screen.dart'
    deferred as def_music_pack;
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_screen.dart'
    deferred as def_my_tune_screen;
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart'
    deferred as def_my_tune_setting_screen;
import 'package:mtn_sa_revamp/files/screens/navigation_bar/mobile_app_bar/mobile_app_bar.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/files/screens/privacy_policy_screen/privacy_policy_screen.dart'
    deferred as def_privacy;
import 'package:mtn_sa_revamp/files/screens/profile_screen/profile_screen.dart'
    deferred as def_profile_screen;
import 'package:mtn_sa_revamp/files/screens/search_screen/artist_tune_screen.dart'
    deferred as def_artist_tune_screen;
import 'package:mtn_sa_revamp/files/screens/search_screen/new_search_screen.dart'
    deferred as def_new_search_screen;

import 'package:mtn_sa_revamp/files/screens/see_more_screen/see_more_screen.dart'
    deferred as def_see_more_screen;
import 'package:mtn_sa_revamp/files/screens/terms_condition/terms_condition_screen.dart'
    deferred as def_terms;
import 'package:mtn_sa_revamp/files/screens/home_page/home_page_banner/sub_views/home_banner_detail_page.dart'
    deferred as def_home_banner_detail;
import 'package:mtn_sa_revamp/files/screens/home_page/web_home_screen.dart'
    deferred as web_home_screen;
import 'package:mtn_sa_revamp/files/screens/wishlist_screen/wishlsit_screen.dart'
    deferred as def_wishlist_screen;
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
        _viewMusicDetailScreen(),
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
    widget: Center(
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
        return DeferredRoute(() => def_artist_tune_screen.loadLibrary(), () {
          printCustom(
              "pathParameters is ===== ${state.uri.queryParameters['categoryName']}");
          String artistName = state.uri.queryParameters['artist'] ?? '';
          artCont.getArtistSongs(artistName);
          return def_artist_tune_screen.ArtistTuneScreen(
              artistName: artistName);
        });
        //ArtistTuneScreen(artistName: artistName);
      },
    ),
  ]);
}

StatefulShellBranch bannerDetailScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: bannerGoRoute,
      path: bannerGoRoute,
      builder: (context, state) {
        return DeferredRoute(() => def_home_banner_detail.loadLibrary(), () {
          BannerDetailController bannerCont = Get.put(BannerDetailController());
          String bannerOrder = state.uri.queryParameters['bannerOrder'] ?? '';
          String type = state.uri.queryParameters['type'] ?? '';
          String searchKey = state.uri.queryParameters['searchKey'] ?? '';
          bannerCont.getDetail(type, bannerOrder, searchKey);
          return def_home_banner_detail.HomeBannerDetailPage(
              type: type, bannerOrder: bannerOrder, searchKey: searchKey);
        });
      },
    ),
  ]);
}

StatefulShellBranch profileScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: profileGoRoute,
      path: profileGoRoute,
      builder: (context, state) {
        //pCont.getProfileDetail();
        return DeferredRoute(() => def_profile_screen.loadLibrary(), () {
          ProfileController _ = Get.put(ProfileController());
          return def_profile_screen.ProfileScreen();
        });
        //const ProfileScreen();
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
        return DeferredRoute(() => def_privacy.loadLibrary(), () {
          return def_privacy.PrivacyPolicyScreen();
        });
        // const PrivacyPolicyScreen();
      },
    ),
  ]);
}

StatefulShellBranch _viewMusicDetailScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: musicDetailListGoRoute,
      path: musicDetailListGoRoute,
      builder: (context, state) {
        //pCont.getProfileDetail();
        return DeferredRoute(() => def_music_detail.loadLibrary(), () {
          String toneCode = state.uri.queryParameters['toneCode'] ?? '';
          String type = state.uri.queryParameters['type'] ?? '';
          late MusicBoxDetailController cont;
          try {
            cont = Get.find();
          } catch (e) {
            cont = Get.put(MusicBoxDetailController());
          }

          printCustom("Called MusicPackDetailListScreen");
          cont.getMusicBoxContent(toneCode, type);
          var screen = def_music_detail.MusicPackDetailListScreen(
            toneCode: toneCode,
            type: type,
          );

          return screen;
        });
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
        return DeferredRoute(() => def_help.loadLibrary(), () {
          return def_help.HelpScreen();
        });
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
        return DeferredRoute(() => def_terms.loadLibrary(), () {
          return def_terms.TermsConditionScreen();
        });
        //const TermsConditionScreen();
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
        return DeferredRoute(() => def_wishlist_screen.loadLibrary(), () {
          return def_wishlist_screen.WishlistScreen();
        });
        //const WishlistScreen();
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
        return DeferredRoute(() => def_my_tune_screen.loadLibrary(), () {
          return def_my_tune_screen.MyTuneScreen();
        });
        //const MyTuneScreen();
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
        return DeferredRoute(() => def_history_screen.loadLibrary(), () {
          return def_history_screen.HistoryScreen();
        });
        //const HistoryScreen();
      },
    ),
  ]);
}

StatefulShellBranch seeMoreScreen() {
  BannerDetailController _ = Get.put(BannerDetailController());
  // keyScrollFocusNode = FocusNode();
  // keyScrollFocusNode.requestFocus();
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: moreGoRoute,
      path: moreGoRoute,
      builder: (context, state) {
        return DeferredRoute(() => def_see_more_screen.loadLibrary(), () {
          List<TuneInfo>? list = state.extra as List<TuneInfo>;
          //customPrint("List is =========== $list");
          if (list.isEmpty) {
            context.go(homeGoRoute);
            return web_home_screen.WebLandingPage();
          }
          return def_see_more_screen.SeeMoreScreen();
        });
        //const SeeMoreScreen();
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
        //return catScreen;
        return DeferredRoute(() => def_cat_screen.loadLibrary(), () {
          printCustom(
              "pathParameters is ===== ${state.uri.queryParameters['categoryName']}");
          String categoryName = state.uri.queryParameters['categoryName'] ?? '';
          String categoryId = state.uri.queryParameters['categoryId'] ?? '';
          var catScreen = def_cat_screen.CategoryScreen(
              category: categoryName, id: categoryId);
          catCont.getCategroyDetail(categoryName, categoryId);
          return catScreen;
        });
      },
    ),
  ]);
}

StatefulShellBranch faqScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: faqGoRoute,
      path: faqGoRoute,
      builder: (context, state) {
        return DeferredRoute(() => def_faq_screen.loadLibrary(), () {
          FaqController _ = Get.put(FaqController());
          return def_faq_screen.FAQScreen();
        });
        //const FAQScreen();
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
        return DeferredRoute(() => def_my_tune_setting_screen.loadLibrary(),
            () {
          String toneId = state.uri.queryParameters['toneId'] ?? '';
          String toneName = state.uri.queryParameters['toneName'] ?? '';
          String toneArtist = state.uri.queryParameters['toneArtist'] ?? '';
          String toneImage = state.uri.queryParameters['toneImage'] ?? '';
          return def_my_tune_setting_screen.MyTuneSettingScreen(
            toneId: toneId,
            toneName: toneName,
            toneArtist: toneArtist,
            toneImage: toneImage,
          );
        });
      },
    ),
  ]);
}

StatefulShellBranch searchScreen() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: searchGoRoute,
      path: searchGoRoute,
      builder: (context, state) {
        return DeferredRoute(() => def_new_search_screen.loadLibrary(), () {
          String searchkey = state.uri.queryParameters['key'] ?? '';
          String index = state.uri.queryParameters['index'] ?? "0";

          SearchType searchType = getSearchType(index);
          NewSearchController newSearchController = Get.find();
          newSearchController.searchedText = searchkey;
          if (searchkey.isNotEmpty) {
            newSearchController.getSearchedResult(searchType);
          }
          return def_new_search_screen.NewSearchScreen();
        });
        //NewSearchScreen();
      },
    ),
  ]);
}

SearchType getSearchType(String index) {
  printCustom("index = $index");
  if (index == "0") {
    return SearchType.toneSearch;
  } else if (index == "1") {
    return SearchType.artistSearch;
  } else if (index == "2") {
    return SearchType.toneIdSearch;
  } else if (index == "3") {
    return SearchType.nameToneSearch;
  } else {
    return SearchType.toneSearch;
  }
}

StatefulShellBranch deleteScreenRoute() {
  return StatefulShellBranch(routes: <RouteBase>[
    GoRoute(
      name: deleteGoRoute,
      path: deleteGoRoute,
      builder: (context, state) {
        return const DeleteScreen();
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
        return DeferredRoute(() => def_music_pack.loadLibrary(), () {
          return def_music_pack.MusicPackScreen();
        });
        //MusicPackScreen();
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
          CustomText(
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
            //const WebLandingPage();

            return DeferredRoute(() => web_home_screen.loadLibrary(),
                () => web_home_screen.WebLandingPage());
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

  printCustom("is this transaction ${pat == pat1} ");

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
        // keyScrollFocusNode.requestFocus();
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
