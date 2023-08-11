import 'dart:io';
import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class ProfileVM {
  Future<HttpClientResponse> getProfileDetail(String msisdn) async {
    var url = getprofileDetailUrl;
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': msisdn,
      'identifier': "GetUserDetails",
      'language': StoreManager().language,
    };
    var parts = [];
    params.forEach((key, value) {
      parts.add('$key='
          '$value');
    });
    var formData = parts.join('&');
    var res = await ServiceCall().post(url, formData);
    print("getProfileDetail ==== $res");
    return res;
  }
}
