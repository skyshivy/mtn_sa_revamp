import 'dart:math';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/buy_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<BuyTuneModel> buyMusicChannelApi(String toneId) async {
  String url = buyMusicChannelUrl;
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  var myPost = {
    "aPartyMsisdn": StoreManager().msisdn,
    "toneId": toneId,
    "clientTxnId": "$randomNumber",
    "language": StoreManager().languageCode,
    "serviceId": "16",
    "channelId": channelId,
    "priority": "0",
    "paymentMode": "2",
  };

  var parts = [];
  myPost.forEach((key, value) {
    parts.add('${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? map = await ServiceCall().post(url, formData);

  if (map != null) {
    BuyTuneModel? model = BuyTuneModel.fromJson(map);
    return model;
  } else {
    BuyTuneModel? model =
        BuyTuneModel(message: someThingWentWrongStr.tr, statusCode: '');
    return model;
  }
}
