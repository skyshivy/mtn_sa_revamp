import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/search_toneid_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<SearchToneidModel> searchToneIdApi(String toneId,
    {int pageNo = 0}) async {
  String url =
      "$searchToneIdUrl?language=${StoreManager().language}&toneId=$toneId&pageNo=$pageNo&perPageCount=$pagePerCount";
  Map<String, dynamic>? map = await ServiceCall().get(url);
  if (map != null) {
    SearchToneidModel searchToneidModel = SearchToneidModel.fromJson(map);

    printCustom(
        "list is ===== ${searchToneidModel.responseMap?.toneList?.length}");
    return searchToneidModel;
  } else {
    printCustom("Map is ");

    return SearchToneidModel();
  }
}
