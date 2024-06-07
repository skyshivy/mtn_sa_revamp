import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/normal_tune_search_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/view_model/normal_search_tune_api.dart';

Future<AdvanceSearchModel> searchTuneApi(String searchedText,
    {int pageNo = 0}) async {
  if (StoreManager().appSetting == null) {
    await Future.delayed(const Duration(seconds: 2));
  }
  Others? others = StoreManager().appSetting?.responseMap?.settings?.others;
  String catId = others?.nameTuneCategoryid?.attribute ?? '0';
  AdvanceSearchModel model =
      await advanceSearchTuneVM([searchedText], catId, pageNo);
  return model;
}
