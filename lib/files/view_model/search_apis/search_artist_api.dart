import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<SearchTuneModel> searchArtistApi(String searchedText,
    {int pageNo = 0}) async {
  String s = searchedText; //.value.trim();
  s = s.replaceAll('+', '%2B');

  var url =
      '$searchSpecificToneUrl=${StoreManager().language}&sortBy=Order_By&perPageCount=$pagePerCount&searchLanguage=${StoreManager().language}&searchKey=$s&pageNo=$pageNo';
  Map<String, dynamic>? result =
      await ServiceCall().get(url); //, params: {"searchKey": s}

  if (result != null) {
    try {
      SearchTuneModel model = SearchTuneModel.fromJson(result);
      return model;
    } catch (e) {
      printCustom("decoding issue = $e");
      return SearchTuneModel(message: someThingWentWrongStr);
    }
  } else {
    printCustom("some thing went wrong  in search");
    return SearchTuneModel(message: someThingWentWrongStr);
  }
}
