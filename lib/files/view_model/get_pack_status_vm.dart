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

  /*
  // below for testing perpose
  String str = """{
   "responseMap":{
      "packStatusDetails":{
         "activeRRBTStatus":"1",
         "activeCRBTStatus":"1",
         "languageId":"1",
         "packName":" shiv pack",
         "rrbtServiceExpiry":"2023-11-10",
         "crbtServiceExpiry":"2023-11-23"
      }
   },
   "message":"Success",
   "respTime":"Nov 17, 2023 9:05:50 PM",
   "statusCode":"SC0000"
}""";
  Map<String, dynamic> map = json.decode(str);
  */

  print("Map is ========= $map");
  if (map != null) {
    PackStatusModel model = PackStatusModel.fromJson(map);
    return model;
  } else {
    return PackStatusModel(message: someThingWentWrongStr);
  }
}
