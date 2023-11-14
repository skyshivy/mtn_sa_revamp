import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<Map<String, dynamic>?> deleteDedicatedTuneApiCall(
    String tuneId, String bparty, String timeType) async {
  //aPartyMsisdn=9975654677&bPartyMsisdn=09090918212&timeType=2&toneId=44729&language=1

  var url = deleteDedicatedTuneUrl;
  Map<String, dynamic> params = {
    'aPartyMsisdn': StoreManager().msisdn,
    'bPartyMsisdn': bparty,
    'timeType': timeType,
    'toneId': tuneId,
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

  //   print("======__Delete___++++++${reps}");
  //   return reps;
  // } on Exception catch (error) {
  //   print('never reached ${error}');
  //   return null;
  // }
}
