import 'dart:io';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class CustomHeader {
  settingHeader(String url, HttpClientRequest request) async {
    /*  
    var pref = await SharedPreferences.getInstance();
      var accessToken = pref.getString('accessToken') ?? '';

      var deviceId = pref.getString('deviceId') ?? '';
      print("Access Token================${accessToken}");
      request.headers.set('accessToken', accessToken, preserveHeaderCase: true);
      request.headers.set('channelId', '4', preserveHeaderCase: true);
      request.headers.set('deviceId', deviceId, preserveHeaderCase: true);
*/
    request.headers.set('Content-Type', 'application/x-www-form-urlencoded',
        preserveHeaderCase: true);
    request.headers.set('versionCode', versionCode, preserveHeaderCase: true);
    request.headers.set('appVersion', appVersion, preserveHeaderCase: true);
    request.headers.set('appId', appId, preserveHeaderCase: true);
    request.headers.set('os', os, preserveHeaderCase: true);
    request.headers.set('Accept', 'application/json', preserveHeaderCase: true);
    request.headers.set('languageId', StoreManager().isEnglish ? '1' : '2',
        preserveHeaderCase: true);

    return request;
  }
}
