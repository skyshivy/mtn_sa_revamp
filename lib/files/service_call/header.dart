import 'dart:io';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class CustomHeader {
  settingHeader(String url, HttpClientRequest request) async {
    if (url.contains("security")) {
      print("Security url================");

      print("Access Token================${StoreManager().accessToken}");
      request.headers.set('accessToken', StoreManager().accessToken,
          preserveHeaderCase: true);
      request.headers.set('channelId', channelId, preserveHeaderCase: true);
      request.headers
          .set('deviceId', StoreManager().deviceId, preserveHeaderCase: true);
    }
    request.headers.set('Content-Type', 'application/x-www-form-urlencoded',
        preserveHeaderCase: true);
    request.headers.set('versionCode', versionCode, preserveHeaderCase: true);
    request.headers.set('appVersion', appVersion, preserveHeaderCase: true);
    request.headers.set('appId', appId, preserveHeaderCase: true);
    request.headers.set('os', os, preserveHeaderCase: true);
    request.headers.set('Accept', 'application/json', preserveHeaderCase: true);
    request.headers.set('languageId', StoreManager().languageCode,
        preserveHeaderCase: true);

    return request;
  }
}
