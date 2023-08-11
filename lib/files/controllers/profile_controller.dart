import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/profile_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/profile_vm.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  GetProfileDetails? profileDetails;

  RxList<AppCategory> catList = <AppCategory>[].obs;

  getPref() async {
    var result = await ServiceCall().get(categoryListUrl);

    if (result != null) {
      CategoryModel model = CategoryModel.fromJson(result);
      catList.value = model.responseMap?.categories ?? [];
    }
  }

  getProfileDetail() async {
    isLoading.value = true;
    await getPref();
    HttpClientResponse resp =
        await ProfileVM().getProfileDetail(StoreManager().msisdn);
    isLoading.value = false;
    final stringData = await resp.transform(utf8.decoder).join();
    Map<String, dynamic> valueMap = json.decode(stringData);
    ProfileModel profileModel = ProfileModel.fromJson(valueMap);
    profileDetails = profileModel.responseMap?.getProfileDetails;
    print("getProfileDetail ==============$stringData");
  }

  updateSelection(int index) {
    catList[index].isSelected?.value = !(catList[index].isSelected!.value);
  }
}
