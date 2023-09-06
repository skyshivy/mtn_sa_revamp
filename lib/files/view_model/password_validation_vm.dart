import 'package:flutter/foundation.dart';
import 'package:mtn_sa_revamp/files/custom_files/encryption.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class PasswordValidationVm {
  Future<Map<String, dynamic>?> validatePassword(
      String msisdn, String securityCounter) async {
    var pass = 'Oem@L#@1';
    var password = "$pass$securityCounter";
    if (kDebugMode) {
      print("password is here $password");
    }
    String encryptedPassword = Cryptom().text(password);
    print("encryptedPassword ==========================$encryptedPassword");
    var params = {
      "msisdn": msisdn,
      "language": StoreManager().language,
      "clientTxnId": "21042020",
      "type": "ValidateDetails",
      "encryptedPassword": encryptedPassword,
      "securityCounter": securityCounter
    };

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
