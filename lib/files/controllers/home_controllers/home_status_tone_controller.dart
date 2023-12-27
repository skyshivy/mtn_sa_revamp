import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/status_tone_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class HomeStatusToneController extends GetxController {
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
  RxBool isLoading = false.obs;
  RxString message = ''.obs;

  getList() async {
    String val = StoreManager()
            .appSetting
            ?.responseMap
            ?.settings
            ?.others
            ?.nameTuneCategoryid
            ?.attribute ??
        '';
    _getStatusTuneList(val);
  }

  Future<StatusToneModel> _getStatusTuneList(String catId) async {
    isLoading.value = true;
    message.value = '';
    String url =
        "${statusToneUrl}language=${StoreManager().language}&categoryId=$catId&sortBy=Order_By&alignBy=ASC&pageNo=0&searchLanguage=${StoreManager().language}&perPageCount=20";
    Map<String, dynamic>? map = await ServiceCall().get(url);
    isLoading.value = false;
    if (map != null) {
      StatusToneModel model = StatusToneModel.fromJson(map);
      if (model.statusCode == 'SC0000') {
        tuneList.value = model.responseMap?.searchList ?? [];
        if (tuneList.isEmpty) {
          message.value = tuneListEmptyStr.tr;
        }
        return model;
      } else {
        message.value = model.message ?? someThingWentWrongStr.tr;

        return model;
      }
    } else {
      tuneList.value = [];
      message.value = someThingWentWrongStr.tr;
      return StatusToneModel(statusCode: "FL0000");
    }
  }
}
