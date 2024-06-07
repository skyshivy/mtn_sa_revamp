import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/search_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<SearchTuneModel> nameTuneSearchApi(String searchKey,
    {int pageNo = 0}) async {
  if (StoreManager().appSetting == null) {
    await Future.delayed(const Duration(seconds: 2));
  }
  Others? others = StoreManager().appSetting?.responseMap?.settings?.others;

  String catId = others?.nameTuneCategoryid?.attribute ?? '0';

  var url =
      "$nameTuneSearchUrl?language=${StoreManager().language}&searchKey=$searchKey&categoryId=$catId&pageNo=$pageNo&perPageCount=$pagePerCount&searchLanguage=${StoreManager().language}";

  Map<String, dynamic>? result =
      await ServiceCall().get(url); //, params: {'searchKey': searchKey}
  printCustom("result is $result");
  if (result != null) {
    SearchTuneModel model = SearchTuneModel.fromJson(result);
    printCustom("list length is  ${model.responseMap?.songList?.length}");

    return model;
  } else {
    printCustom("some thing went wrong  in search");
    return SearchTuneModel(message: someThingWentWrongStr);
  }
}
