import 'dart:io';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class CustomHeader {
  settingHeader(String url, HttpClientRequest request) async {
    //text.substring(3);

    if (url.contains("security") || StoreManager().isLoggedIn) {
      printCustom("Security url================");
      String mobileNumber = StoreManager().msisdn;
      printCustom("Security url================");
      String checkString = mobileNumber[0];
      printCustom("checkString SKY================ $checkString");
      String msisdnWithoutZero = '';
      if (mobileNumber[0] == "0") {
        printCustom("Contain zero  ");
        msisdnWithoutZero = mobileNumber.substring(1);

        printCustom("Contain zero  $msisdnWithoutZero ");
      } else {
        msisdnWithoutZero = mobileNumber;
        printCustom("does not Contain zero  $msisdnWithoutZero");
      }
      //text.substring(3);

      printCustom("msisdn SKY================ ");
      printCustom("msisdn SKY================ ");
      request.headers
          .set('msisdn', msisdnWithoutZero, preserveHeaderCase: true);
// if (Constant.addMsisdn) {
//       Constants.addMsisdn = false;
//       request.headers.set('msisdn', msisdn!, preserveHeaderCase: true);
//     }
      printCustom("Access Token================${StoreManager().accessToken}");
      request.headers.set('accessToken', StoreManager().accessToken,
          preserveHeaderCase: true);
      request.headers.set('channelId', channelId, preserveHeaderCase: true);
      request.headers
          .set('deviceId', StoreManager().deviceId, preserveHeaderCase: true);
    }
    request.headers.set(
        'Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8',
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
