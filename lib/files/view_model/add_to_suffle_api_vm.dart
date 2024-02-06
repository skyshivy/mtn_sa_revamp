import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<Map<String, dynamic>?> addToSuffleApi(String toneId, bool isCrbt) async {
  String url = addToneToSuffleUrl;
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  var myPost = {
    'clientTxnId': '$randomNumber',
    'serviceId': '1',
    'aPartyMsisdn': StoreManager().msisdn,
    'channelId': channelId,
    'toneIdList': [
      {"toneId": toneId}
    ],
    'priority': isCrbt ? '0' : '1',
    'activityId': '1',
    'language': StoreManager().languageCode,
  };

  var parts = [];
  myPost.forEach((key, value) {
    parts.add('$key='
        '$value');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? map = await ServiceCall().post(url, formData);
  return map;
}
