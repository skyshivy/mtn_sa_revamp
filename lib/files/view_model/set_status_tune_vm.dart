import 'dart:math';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/set_status_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<SetStatusTuneModel> setStatusTuneVm(String packName, String tuneId,
    String startDate, String endDate, String startTime, String endTime) async {
  String url = setStatusTuneUrl;

  Random random = Random();
  int randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> body = {
    'clientTxnId': randomNumber.toString(),
    'language': StoreManager().languageCode,
    'serviceId': '6',
    'aPartyMsisdn': StoreManager().msisdn,
    'packName': packName,
    'toneId': tuneId,
    'startDate': startDate,
    'endDate': endDate,
    'startTime': startTime,
    'endDTime': endTime,
    'channel': channelId,
  };
  var parts = [];
  body.forEach((key, value) {
    parts.add('${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}');
  });
  var formData = parts.join('&');

  Map<String, dynamic>? map = await ServiceCall().post(url, formData);
  if (map != null) {
    SetStatusTuneModel mode = SetStatusTuneModel.fromJson(map);
    return mode;
  } else {
    return SetStatusTuneModel(
        statusCode: 'FL0000', message: someThingWentWrongStr.tr);
  }
}
