import 'dart:math';

import 'package:mtn_sa_revamp/files/model/set_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<Map<String, dynamic>?> addToSuffleApi(String toneId, bool isCrbt) async {
  String url = timeBaseTuneSetUrl;
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  var myPost = {
    'clientTxnId': '$randomNumber',
    'aPartyMsisdn': StoreManager().msisdn,
    'toneId': toneId,
    'language': StoreManager().languageCode,
    'priority': isCrbt ? '0' : '1',
    'channelId': channelId,
    'serviceId': '17',
    'activityId': '1',
    'timeType': '2',
    'weeklyDays': '0',
    'weeklyStartTime': '00:00',
    'weeklyEndTime': '23:59'
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
