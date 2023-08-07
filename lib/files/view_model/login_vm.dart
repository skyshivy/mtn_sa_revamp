import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class LoginVm {
  Future<String> subscribeMsisdn(String msisdn) async {
    var url = subscriberValidationUrl;
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    var myPost = {
      "language": StoreManager().language,
      "clientTxnId": "$randomNumber",
      "type": "CheckMsisdnSendOTP"
    };
    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    print("\nformed data is \n$formData\n");

    HttpClientResponse response =
        await ServiceCall().postMsisdnValidation(url, msisdn, formData);
    final stringData = await response.transform(utf8.decoder).join();

    return stringData;
  }
}
