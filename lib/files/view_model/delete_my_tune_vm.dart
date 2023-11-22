import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<Map<String, dynamic>?> deleteMyTuneApiCall(
    String tuneId, String packName) async {
  Random random = Random();
  var randomNumber = random.nextInt(1000000000);
  var url = deleteTuneUrl;
  Map<String, dynamic> params = {
    'msisdn': StoreManager().msisdn,
    'toneId': tuneId,
    'packName': packName,
    'language': StoreManager().languageCode,
  };
  var parts = [];
  params.forEach((key, value) {
    parts.add('${key}='
        '${value}');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? map = await ServiceCall().post(url, formData);
  return map;
  // var request = await client.postUrl(Uri.parse(url));
  // request = await Header().settingHeader(url, request);
  // request.write(formData);
  // try {
  //   HttpClientResponse response = await request.close();
  //   var reps = await GenericServiceCall().httpServiceCall(request);

  //   printCustom("======__Delete___++++++${reps}");
  //   return reps;
  // } on Exception catch (error) {
  //   printCustom('never reached ${error}');
  //   return null;
  // }
}
