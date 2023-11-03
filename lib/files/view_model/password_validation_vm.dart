import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mtn_sa_revamp/files/custom_files/encryption.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class PasswordValidationVm {
  Future<Map<String, dynamic>?> validatePassword(
      String msisdn, String securityCounter, bool isAutoLogin) async {
    var pass = password; //isAutoLogin ? '' : 'Oem@L#@1';
    var appendPassword = "$pass$securityCounter";
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    if (kDebugMode) {
      print("password is here $appendPassword");
    }
    String encryptedPassword = Cryptom().text(appendPassword);
    print("encryptedPassword ==========================\n$encryptedPassword\n");
    Map<String, String> params = {};
    if (isAutoLogin) {
      print("Password is \n$pass\n");
      print("securityCounter is \n$securityCounter\n");

      params = {
        'msisdn': msisdn,
        'username': userName,
        "language": StoreManager().language,
        "clientTxnId": "$randomNumber",
        "type": "ValidateDetails",
        "encryptedPassword": encryptedPassword,
        "securityCounter": securityCounter
      };
    } else {
      params = {
        "msisdn": msisdn,
        "language": StoreManager().language,
        "clientTxnId": "$randomNumber",
        "type": "ValidateDetails",
        "encryptedPassword": encryptedPassword,
        "securityCounter": securityCounter
      };
    }
    print("Password validation Data ==== $params");

    var parts = [];
    params.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    String url = passwordValidationUrl;
    Map<String, dynamic>? map = await ServiceCall().post(url, formData);
    return map;
  }
}
