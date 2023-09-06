import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class GetTunePrice {
  Future<Map<String, dynamic>?> api(String msisdn, String toneId) async {
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    var body = {
      'clientTxnId': randomNumber.toString(),
      'language': StoreManager().languageCode,
      'serviceId': '1',
      'aPartyMsisdn': msisdn,
      'bPartyMsisdnList': '',
      'toneId': toneId,
      'validationIdentifier': '3',
      'channelId': channelId,
    };
    await ServiceCall().regenarateTokenFromOtherClass();
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
