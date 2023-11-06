import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class GetTunePrice {
  Future<Map<String, dynamic>?> api(
      String msisdn, String toneId, String validationIdentifier,
      {String? bParty}) async {
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    List<Map<String, dynamic>> lst = [
      {"bPartyMsisdn": "$bParty"}
    ];

    printCustom("Bparty map = $lst");
    var body = {
      'clientTxnId': randomNumber.toString(),
      'language': StoreManager().languageCode,
      'serviceId': '1',
      'aPartyMsisdn': msisdn,
      'bPartyMsisdnList': bParty == null ? '' : lst,
      'toneId': toneId,
      'validationIdentifier': validationIdentifier, //'3',
      'channelId': channelId,
    };
    //await ServiceCall().regenarateTokenFromOtherClass();
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value.toString())}');
    });
    var formData = parts.join('&');
    printCustom("\nformed data is \n$formData\n");

    Map<String, dynamic>? request =
        await ServiceCall().post(getTonePriceUrl, formData);
    printCustom("request is $request");
    return request;
  }
}
