import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<Map<String, dynamic>?> deletePlayingTuneApiCall(
    String tuneId, String timeType, bool isFullDay) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  var url = deletePlayingTuneUrl;
  Map<String, dynamic> params = {
    'clientTxnId': '$randomNumber',
    'aPartyMsisdn': StoreManager().msisdn,
    'toneIdList': [
      {"toneId": tuneId}
    ],
    'language': StoreManager().languageCode,
    'priority': '0',
    'channelId': channelId,
    'timeType': timeType,
    'activityId': '3',
    'serviceId': isFullDay ? '1' : '17',
  };
  var parts = [];
  params.forEach((key, value) {
    parts.add('${key}='
        '${value}');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? map = await ServiceCall().post(url, formData);
  return map;
}
