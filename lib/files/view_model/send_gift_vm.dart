import 'dart:math';

import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class SendGiftVM {
  Future<Map<String, dynamic>?> send(
      String bParty, String toneId, String packName, String toneName) async {
    var parts = [];
    // Random random = Random();
    // int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> body = {
      'msisdnA': StoreManager().msisdn,
      'msisdnB': bParty,
      'toneId': toneId,
      'channel': channelId,
      'username': StoreManager().msisdn,
      'language': StoreManager().languageCode,
      'packName': packName, //'3',
      'toneName': toneName,
    };
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value.toString())}');
    });
    var formData = parts.join('&');
    printCustom("\nformed data is \n$formData\n");

    Map<String, dynamic>? request =
        await ServiceCall().post(sendGiftUrl, formData);
    printCustom("request is $request");
    return request;
  }
}
