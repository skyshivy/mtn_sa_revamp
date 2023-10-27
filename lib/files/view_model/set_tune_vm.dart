import 'dart:math';

import 'package:mtn_sa_revamp/files/model/buy_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class SetTuneVM {
  Future<BuyTuneModel> set(TuneInfo info, String packName) async {
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    var body = {
      'clientTxnId': randomNumber.toString(),
      'language': StoreManager().languageCode,
      'msisdn': StoreManager().msisdn,
      'toneId': info.toneId,
      'toneName': info.toneName,
      'packName': packName,
      'username': StoreManager().msisdn,
      'channelId': channelId,
    };

    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value.toString())}');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? map = await ServiceCall().post(buyTuneUrl, formData);

    if (map != null) {
      BuyTuneModel? model = BuyTuneModel.fromJson(map!);
      return model;
    } else {
      BuyTuneModel? model =
          BuyTuneModel(message: someThingWentWrongStr, statusCode: '');
      return model;
    }
  }
}