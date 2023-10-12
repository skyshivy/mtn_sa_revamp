import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/edit_profile.dart';
import 'package:mtn_sa_revamp/files/model/profile_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/profile_vm.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool editEnable = false.obs;
  RxString userName = ''.obs;
  RxBool isSaving = false.obs;
  RxList<String> selectedCatList = <String>[].obs;
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
    selectedCatList.clear();
    isLoading.value = true;
    //await ServiceCall().regenarateTokenFromOtherClass();
    await getPref();
    Map<String, dynamic>? res =
        await ProfileVM().getProfileDetail(StoreManager().msisdn);

    isLoading.value = false;

    if (res != null) {
      ProfileModel profileModel = ProfileModel.fromJson(res);
      profileDetails = profileModel.responseMap?.getProfileDetails;
      userName.value = profileDetails?.userName ?? '';
      if ((profileDetails?.categories ?? "").isNotEmpty) {
        selectedCatList.value = (profileDetails?.categories ?? "").split(',');
      }

      print("Selected selectedCatList  ${selectedCatList.length}");
    }
  }

  updateSelection(int index) {
    catList[index].isSelected?.value = !(catList[index].isSelected!.value);
    selectedCatList.clear();
    for (AppCategory item in catList) {
      if (item.isSelected!.value) {
        selectedCatList.add(item.categoryId ?? '');
      }
    }

    selectedCatList.value = selectedCatList.toSet().toList();
    print("selected id = ${selectedCatList.join(',')}");
  }

  editButtonAction() {
    editEnable.value = !editEnable.value;
    if (!editEnable.value) {
      saveEdit();
    }
  }

  updateUserName(String text) {
    userName.value = text;
  }

  saveEdit() async {
    print("Save api call ======== ${selectedCatList} ");
    if (selectedCatList.isEmpty) {
      editEnable.value = true;
      showSnackBar(message: selectAtleastOneCatStr);
      return;
    }
    print(
        "Save api call  user name ${profileDetails?.userName}  new ${userName.value}");
    isSaving.value = true;
    if (profileDetails?.userName != userName.value) {
      EditProfileModel? result1 =
          await ProfileVM().editProfile(false, userName: userName.value);
    }
    EditProfileModel? result =
        await ProfileVM().editProfile(true, catIs: selectedCatList.join(','));

    isSaving.value = false;
  }

  cancelButton() {
    editEnable.value = false;
    selectedCatList.value = (profileDetails?.categories ?? "").split(',');
  }
}
