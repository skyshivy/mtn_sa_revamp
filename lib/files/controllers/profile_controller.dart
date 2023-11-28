import 'dart:convert';
import 'dart:io';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/edit_profile.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/profile_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/profile_vm.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool editEnable = false.obs;
  RxBool isHideCRBTStatus = true.obs;
  RxBool isHideRRBTStatus = true.obs;
  RxString userName = ''.obs;
  RxBool isSaving = false.obs;
  RxString packName = ''.obs;
  RxString tuneStatus = ''.obs;
  String tuneStatusMessage = '';
  String rrbtStatusMessage = '';
  RxBool isBothStatusHidden = true.obs;
  RxString rrbtStatus = ''.obs;
  RxString tuneExire = ''.obs;
  RxString rrbtExpire = ''.obs;
  RxString activeTuneButtonName = ''.obs;
  RxString activeRrbtButtonName = ''.obs;
  RxList<String> selectedCatList = <String>[].obs;
  GetProfileDetails? profileDetails;

  RxList<AppCategory> catList = <AppCategory>[].obs;

  getPref() async {
    var result = await ServiceCall().get(categoryListUrl);

    if (result != null) {
      CategoryModel model = CategoryModel.fromJson(result);
      catList.value = model.responseMap?.categories ?? [];
      print("category is ${catList.length}");
    }
  }

  Future<void> getCrbtPackStatus() async {
    PackStatusModel? packStatusModel = await getPackStatusApiCall(isCrbt: true);

    if (packStatusModel.statusCode == 'SC0000') {
      isHideCRBTStatus.value =
          (packStatusModel.responseMap?.packStatusDetails?.packName != null);

      return;
    }
    isHideCRBTStatus.value = true;
  }

  Future<void> getRrbtPackStatus() async {
    PackStatusModel? packStatusModel =
        await getPackStatusApiCall(isCrbt: false);
    if (packStatusModel.statusCode == 'SC0000') {
      isHideRRBTStatus.value =
          (packStatusModel.responseMap?.packStatusDetails?.packName != null);
      return;
    }
    isHideRRBTStatus.value = true;
  }

  Future<PlayingTuneModel?> getMyTunes() async {
    PlayingTuneModel? playing;
    Map<String, dynamic>? result = await ServiceCall().get(getPlayingTunesUrl);
    print("result si ");
    if (result != null) {
      PlayingTuneModel? mod = PlayingTuneModel.fromJson(result);
      playing = PlayingTuneModel.fromJson(result);
      if (mod.statusCode == "SC0000") {
        PackUserDetailsCrbt? detail =
            mod.responseMap?.listToneApk?.first.packUserDetailsCrbt;
        String suspendStatus = detail?.isSuspend ?? '';
        String suspendStatus1 = detail?.isSuspend ?? '';
        tuneExire.value = detail?.packExpiry ?? '';
        packName.value = detail?.packName ?? '';
        activeRrbtButtonName.value =
            (suspendStatus == "T") ? resumeStr : suspendStr;
        activeTuneButtonName.value =
            (suspendStatus1 == "T") ? resumeStr : suspendStr;
        rrbtStatusMessage = (suspendStatus1 == "T")
            ? yourServiceIsNotCurrentlyRunningStr
            : yourServiceIsCurrentlyRunningStr;
        tuneStatusMessage = (suspendStatus1 == "T")
            ? yourServiceIsNotCurrentlyRunningStr
            : yourServiceIsCurrentlyRunningStr;
        rrbtStatus.value = (suspendStatus == "T") ? suspendStr : activeStr;
        tuneStatus.value = (suspendStatus == "T") ? suspendStr : activeStr;

        return playing;
      } else {
        return playing;
      }
    }
    return playing;
  }

  getProfileDetail() async {
    selectedCatList.clear();
    isLoading.value = true;
    //await ServiceCall().regenarateTokenFromOtherClass();
    await getPref();
    await getCrbtPackStatus();
    await getRrbtPackStatus();
    await getMyTunes();
//isBothStatusHidden.value = isHideCRBTStatus.value;
    isBothStatusHidden.value =
        (isHideCRBTStatus.value || isHideRRBTStatus.value);

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

      printCustom("Selected selectedCatList  ${selectedCatList.length}");
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
    printCustom("selected id = ${selectedCatList.join(',')}");
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
    printCustom("Save api call ======== ${selectedCatList} ");
    if (selectedCatList.isEmpty) {
      editEnable.value = true;
      showSnackBar(message: selectAtleastOneCatStr.tr);
      return;
    }
    printCustom(
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

  activeTuneStatusAction() {
    printCustom("activeTuneStatusAction");
  }

  suspendTuneStatusAction() {
    printCustom("suspendTuneStatusAction");
  }

  unsubscribeTuneStatusAction() {
    printCustom("unsubscribeTuneStatusAction");
  }

  activeRrbtStatusAction() {
    printCustom("activeRrbtStatusAction");
  }

  suspendRrbtStatusAction() {
    printCustom("suspendRrbtStatusAction");
  }

  unSubscribeRrbtStatusAction() {
    printCustom("unSubscribeRrbtStatusAction");
  }
}
