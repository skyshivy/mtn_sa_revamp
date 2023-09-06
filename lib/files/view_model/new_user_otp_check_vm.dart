import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class NewUserOtpCheckVm {
  check(String otp, String msisdn, String securityToken) async {
    var url = checkOtpNewUserUrl;
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, String> myPost = {
      "otp": otp,
      "msisdn": msisdn,
      "language": StoreManager().language,
      "clientTxnId": "$randomNumber",
      "secToc": securityToken,
      "type": "ValidateDetails"
    };

    var parts = [];
    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });

    var formData = parts.join('&');
    Map<String, dynamic>? map = await ServiceCall().post(url, formData);

    print(map);
  }
}
