// ignore_for_file: unused_local_variable, must_be_immutable
//import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/main_initial.dart' deferred as ini;

BuildContext? goRouterContext;
late PlayerController playerController;
//FocusNode keyScrollFocusNode = FocusNode();
void main() async {
  if (kDebugMode) {
    appId = "com.sixdee.oml_rbt_portal";
  } else {}
  await ini.loadLibrary();
  await ini.intialInitialization();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: Duration(minutes: timeOut),
        invalidateSessionForUserInactivity: Duration(minutes: timeOut));

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        sessionLogoutTime();
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        sessionLogoutTime();
      }
    });

    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: blue),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
    // MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       backgroundColor: Colors.white,
    //       body: DeferredRoute(
    //         () async {
    //           await ini.loadLibrary();
    //           return await ini.intialInitialization();
    //         },
    //         () {
    //           return
    //         },
    //       ),
    //     ));
    // DeferredRoute(() async {
    //   await ini.loadLibrary();

    //   return await ini.intialInitialization();
    //   //return ini.intialInitialization();
    // }, () {
    //   return

    // });
  }

  void sessionLogoutTime() {
    if (StoreManager().isLoggedIn) {
      Get.dialog(CustomConfirmAlertView(
        message: sessionExpiredStr,
        onOk: () {
          goRouterContext?.go(homeGoRoute);

          printCustom("Logout called from main");
          StoreManager().logout();
        },
      ));
    }
  }
}

class DeferredRoute extends StatelessWidget {
  const DeferredRoute(this.future, this.buildChild, {super.key});
  final Future<dynamic> Function() future;
  final Widget Function() buildChild;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: future(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildChild();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
