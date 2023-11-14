import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class GetTunePrice {
  Future<Map<String, dynamic>?> api(String msisdn, String toneId,
      {String? bParty, String validationId = '3'}) async {
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    List<Map<String, dynamic>> lst = [
      {"bPartyMsisdn": "$bParty"}
    ];

    print("Bparty map = $lst");
    var body = {
      'clientTxnId': randomNumber.toString(),
      'language': StoreManager().languageCode,
      'serviceId': '1',
      'aPartyMsisdn': msisdn,
      'bPartyMsisdnList': bParty == null ? '' : lst,
      'toneId': toneId,
      'validationIdentifier': validationId, //'3',
      'channelId': channelId,
    };

    // var body = {
    //   'clientTxnId': randomNumber.toString(),
    //   'language': StoreManager().languageCode,
    //   'serviceId': '1',
    //   'aPartyMsisdn': msisdn,
    //   'bPartyMsisdnList': '',
    //   'toneId': toneId,
    //   'validationIdentifier': '3',
    //   'channelId': channelId,
    // };
    //await ServiceCall().regenarateTokenFromOtherClass();
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value.toString())}');
    });
    var formData = parts.join('&');
    print("\nformed data is \n$formData\n");

    Map<String, dynamic>? request =
        await ServiceCall().post(getTonePriceUrl, formData);
    print("request is $request");
    return request;
  }
}
