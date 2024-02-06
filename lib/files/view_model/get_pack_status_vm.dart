import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<PackStatusModel> getPackStatusApiCall(String msisdn,
    {bool isCrbt = true}) async {
  //String msisdn = StoreManager().msisdn;
  //String lang = StoreManager().language;
  String priority = isCrbt ? "0" : "1";
  String url = "${getpackStatusUrl}msisdn=$msisdn&priority=$priority";
  Map<String, dynamic>? map = await ServiceCall().get(url);
/*
  await Future.delayed(Duration(seconds: 1));

  String str = """{
    "responseMap": {
        "packStatusDetails": {
            "languageId": "1",
            "packName": "CRBT_DAILY"
        }
    },
    "message": "Success",
    "respTime": "Nov 28, 2023 4:14:26 PM",
    "statusCode": "FL0014"
}""";
  String str1 = """{
    "responseMap": {
        "packStatusDetails": {
            "languageId": "1",
            "packName": "RRBT_DAILY"
        }
    },
    "message": "Success",
    "respTime": "Nov 28, 2023 4:14:26 PM",
    "statusCode": "FL0014"
}""";

  // below for testing perpose
  String str = """{
   "responseMap":{
      "packStatusDetails":{
         "activeRRBTStatus":"1",
         "activeCRBTStatus":"1",
         "languageId":"1",
         "packName": "CRBT_DAILY",
         "rrbtServiceExpiry":"2023-11-10",
         "crbtServiceExpiry":"2023-11-23"
      }
   },
   "message":"Success",
   "respTime":"Nov 17, 2023 9:05:50 PM",
   "statusCode":"SC0000"
}""";
Map<String, dynamic> map = json.decode(str);
Map<String, dynamic> map = json.decode(isCrbt ? str : str1);
*/

  printCustom("Map is ========= $map");
  if (map != null) {
    PackStatusModel model = PackStatusModel.fromJson(map);
    if (model.statusCode == 'SC0000') {
      if (isCrbt) {
        StoreManager().crbtPackStatus = model.responseMap?.packStatusDetails;
      } else {
        StoreManager().rrbtPackStatus = model.responseMap?.packStatusDetails;
      }
    }
    return model;
  } else {
    return PackStatusModel(
      respTime: '',
      responseMap: null,
      message: someThingWentWrongStr.tr,
      statusCode: 'FL0000',
    );
  }
}
