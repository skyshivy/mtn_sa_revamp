import 'dart:html';

import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<PackStatusModel> getPackStatusApiCall() async {
  // print("Callling pack detail api");
  // var res = await ProfileVM().getPackDetail();
  // var packName = res.responseMap?.packStatusDetails?.packName;
  // print("pack name is ${packName}");
  // print("After Callling pack detail api ");
  // return packName;

  String msisdn = StoreManager().msisdn;
  String lang = StoreManager().language;

  String url = "${getpackStatusUrl}msisdn=$msisdn&language=$lang";
  Map<String, dynamic>? map = await ServiceCall().get(url);
  if (map != null) {
    PackStatusModel model = PackStatusModel.fromJson(map);
    return model;
  } else {
    return PackStatusModel(message: someThingWentWrongStr);
  }
  // var request = await client.getUrl(Uri.parse(url));
  // request = await Header().settingHeader(url, request);

  // try {
  //   var reps = await GenericServiceCall().httpServiceCall(request);
  //   print("======_____++++++${reps}");
  //   if (reps != null) {
  //     PackStatusModel result = PackStatusModel.fromJson(reps!);
  //     return result;
  //   }
  //   return PackStatusModel();
  // } on Exception catch (error) {
  //   print('never reached ${error}');
  //   return PackStatusModel();
  // }
}
