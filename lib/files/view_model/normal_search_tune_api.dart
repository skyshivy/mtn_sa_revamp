import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/normal_tune_search_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<AdvanceSearchModel> advanceSearchTuneVM(
    List<String> lst, String category, int pageNo) async {
  List<String> idlst = ["!$category"];
  var myPost = {
    "sortBy": "OrderBy",
    "pageNo": pageNo,
    "perPageCount": pagePerCount,
    "filter": "Content",
    "filterPref": "custom",
    "locale": StoreManager().isEnglish ? "en" : "my",
    "msisdn": StoreManager().msisdn,
    "searchKey": lst,
    "categoryId": idlst,
  };

  Map<String, dynamic>? map =
      await ServiceCall().post(advanceSearchTuneUrl, null, jsonData: myPost);

  print("Seach resp is $map ");
  if (map != null) {
    AdvanceSearchModel searchTuneModel = AdvanceSearchModel.fromJson(map);
    return searchTuneModel;
  } else {
    //AdvanceSearchModel searchTuneModel = AdvanceSearchModel.fromJson(map);
    return AdvanceSearchModel(message: someThingWentWrongStr.tr);
  }
}
