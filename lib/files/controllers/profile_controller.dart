import 'dart:convert';
import 'dart:io';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/edit_profile.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/profile_model.dart';
import 'package:mtn_sa_revamp/files/model/suspend_resume_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/active_suspend_api.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/profile_vm.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool editEnable = false.obs;
  RxBool isHideCRBTStatus = true.obs;
  RxBool isHideRRBTStatus = true.obs;
  RxString userName = ''.obs;
  RxBool isSaving = false.obs;
  //RxString packName = ''.obs;
  RxString crbtPackName = ''.obs;
  String rrbtPackName = '';
  RxString crbtTuneStatus = ''.obs;
  RxString crbtTuneStatusMessage = ''.obs;
  RxString rrbtStatusMessage = ''.obs;
  RxBool isBothStatusHidden = true.obs;
  RxString rrbtStatus = ''.obs;
  RxBool isUpdatingCrbtStatus = false.obs;
  RxBool isUpdatingRrbtStatus = false.obs;
  RxString tuneExire = ''.obs;
  RxString rrbtExpire = ''.obs;
  RxString activeCrbtButtonName = ''.obs;
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
    print("getCrbtPackStatus resp message is = ${packStatusModel.message}");
    print("getCrbtPackStatus resp message is = ${packStatusModel.statusCode}");
    if (packStatusModel.statusCode == 'SC0000') {
      isHideCRBTStatus.value =
          !(packStatusModel.responseMap?.packStatusDetails?.packName != null);
      crbtPackName.value =
          packStatusModel.responseMap?.packStatusDetails?.packName ?? '';
      activeCrbtButtonName.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? activeStr.tr
              : suspendStr.tr;
      crbtTuneStatusMessage.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? yourServiceIsNotCurrentlyRunningStr
              : yourServiceIsCurrentlyRunningStr;
      crbtTuneStatus.value = activeStr.tr;
      return;
    } else if (packStatusModel.statusCode == 'FL0014') {
      activeCrbtButtonName.value = activeStr.tr;
      crbtTuneStatusMessage.value = yourServiceIsNotCurrentlyRunningStr;
      isHideCRBTStatus.value = false;
      crbtTuneStatus.value = suspendStr.tr;
    } else {
      crbtPackName.value = '';
      isHideCRBTStatus.value = true;
      return;
    }
  }

  Future<void> getRrbtPackStatus() async {
    PackStatusModel? packStatusModel =
        await getPackStatusApiCall(isCrbt: false);
    print("getCrbtPackStatus resp message is = ${packStatusModel.message}");
    print("getCrbtPackStatus resp message is = ${packStatusModel.statusCode}");
    if (packStatusModel.statusCode == 'SC0000') {
      isHideRRBTStatus.value =
          !(packStatusModel.responseMap?.packStatusDetails?.packName != null);

      rrbtPackName =
          packStatusModel.responseMap?.packStatusDetails?.packName ?? '';
      activeRrbtButtonName.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? activeStr.tr
              : suspendStr.tr;
      rrbtStatusMessage.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? yourServiceIsNotCurrentlyRunningStr
              : yourServiceIsCurrentlyRunningStr;
      rrbtStatus.value = activeStr.tr;
      return;
    } else if (packStatusModel.statusCode == 'FL0014') {
      rrbtStatus.value = suspendStr.tr;
      activeRrbtButtonName.value = activeStr.tr;

      rrbtStatusMessage.value = yourServiceIsNotCurrentlyRunningStr;
      isHideRRBTStatus.value = false;
    } else {
      rrbtPackName = '';
      isHideRRBTStatus.value = true;
      return;
    }
  }

/*
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
        rrbtExpire.value = detail?.packExpiry ?? '';
        //packName.value = detail?.packName ?? '';

        activeRrbtButtonName.value =
            (suspendStatus == "T") ? resumeStr : suspendStr;
        rrbtStatus.value = (suspendStatus == "T") ? suspendStr : activeStr;
        rrbtStatusMessage = (suspendStatus1 == "T")
            ? yourServiceIsNotCurrentlyRunningStr
            : yourServiceIsCurrentlyRunningStr;

        activeCrbtButtonName.value =
            (suspendStatus1 == "T") ? resumeStr : suspendStr;
        crbtTuneStatus.value = (suspendStatus == "T") ? suspendStr : activeStr;
        crbtTuneStatusMessage = (suspendStatus1 == "T")
            ? yourServiceIsNotCurrentlyRunningStr
            : yourServiceIsCurrentlyRunningStr;

        return playing;
      } else {
        return playing;
      }
    }
    return playing;
  }
*/
  getProfileDetail() async {
    selectedCatList.clear();
    isLoading.value = true;
    //await ServiceCall().regenarateTokenFromOtherClass();
    await getPref();
    await getCrbtPackStatus();
    await getRrbtPackStatus();
    //await getMyTunes();
    checkHideAndUnhide();
    print(
        "Status is = ${isHideCRBTStatus.value}  \n ${isHideRRBTStatus.value}");
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

  checkHideAndUnhide() {
    if (isHideCRBTStatus.value) {
      if (isHideRRBTStatus.value) {
        isBothStatusHidden.value = true;
      } else {
        isBothStatusHidden.value = false;
      }
    } else {
      isBothStatusHidden.value = false;
    }
    print("Should hide Status both ${isBothStatusHidden.value}");
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
      if (result1?.statusCode == "SC0000") {
      } else {
        userName.value = profileDetails?.userName ?? '';
      }
    }
    EditProfileModel? result =
        await ProfileVM().editProfile(true, catIs: selectedCatList.join(','));

    isSaving.value = false;
  }

  cancelButton() {
    editEnable.value = false;
    selectedCatList.value = (profileDetails?.categories ?? "").split(',');
  }

  activeCrbtStatusAction() async {
    Get.dialog(
      CustomConfirmAlertView(
        message: changeStatusConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingCrbtStatus.value = true;
          SuspendResumeModel res =
              await activeSuspendApi(crbtPackName.value, true, true);
          isUpdatingCrbtStatus.value = false;
          if (res.statusCode == 'SC0000') {
            activeCrbtButtonName.value =
                (activeCrbtButtonName.value == suspendStr)
                    ? resumeStr
                    : suspendStr;
            crbtTuneStatus.value =
                (crbtTuneStatus.value == activeStr) ? suspendStr : activeStr;
            crbtTuneStatusMessage.value = (crbtTuneStatusMessage.value ==
                    yourServiceIsCurrentlyRunningStr)
                ? yourServiceIsNotCurrentlyRunningStr
                : yourServiceIsCurrentlyRunningStr;
          } else {
            showSnackBar(message: res.message ?? someThingWentWrongStr.tr);
          }
        },
      ),
    );

    printCustom("activeTuneStatusAction");
  }

  suspendCrbtStatusAction() async {
    printCustom("suspendTuneStatusAction");
    Get.dialog(
      CustomConfirmAlertView(
        message: changeStatusConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingCrbtStatus.value = true;
          SuspendResumeModel res =
              await activeSuspendApi(crbtPackName.value, false, true);
          isUpdatingCrbtStatus.value = false;

          if (res.statusCode == 'SC0000') {
            activeCrbtButtonName.value =
                (activeCrbtButtonName.value == suspendStr)
                    ? resumeStr
                    : suspendStr;
            crbtTuneStatus.value =
                (crbtTuneStatus.value == activeStr) ? suspendStr : activeStr;
            crbtTuneStatusMessage.value = (crbtTuneStatusMessage.value ==
                    yourServiceIsCurrentlyRunningStr)
                ? yourServiceIsNotCurrentlyRunningStr
                : yourServiceIsCurrentlyRunningStr;
          } else {
            showSnackBar(message: res.message ?? someThingWentWrongStr.tr);
          }
        },
      ),
    );
    printCustom("activeTuneStatusAction");
  }

  unsubscribeCrbtTuneStatusAction() async {
    printCustom("unsubscribeCrbtTuneStatusAction");
    Get.dialog(
      CustomConfirmAlertView(
        message: unSubscribeConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingCrbtStatus.value = true;
          await Future.delayed(const Duration(seconds: 2));
          isUpdatingCrbtStatus.value = false;
        },
      ),
    );
  }

  activeRrbtStatusAction() async {
    printCustom("activeRrbtStatusAction");
    Get.dialog(
      CustomConfirmAlertView(
        message: changeStatusConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingRrbtStatus.value = true;
          SuspendResumeModel res =
              await activeSuspendApi(rrbtPackName, true, false);
          isUpdatingRrbtStatus.value = false;
          if (res.statusCode == 'SC0000') {
            activeRrbtButtonName.value =
                (activeRrbtButtonName.value == suspendStr)
                    ? resumeStr
                    : suspendStr;
            rrbtStatus.value =
                (rrbtStatus.value == activeStr) ? suspendStr : activeStr;
            rrbtStatusMessage.value =
                (rrbtStatusMessage.value == yourServiceIsCurrentlyRunningStr)
                    ? yourServiceIsNotCurrentlyRunningStr
                    : yourServiceIsCurrentlyRunningStr;
          } else {
            showSnackBar(message: res.message ?? someThingWentWrongStr.tr);
          }
        },
      ),
    );
  }

  suspendRrbtStatusAction() async {
    printCustom("suspendRrbtStatusAction");
    Get.dialog(
      CustomConfirmAlertView(
        message: changeStatusConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingRrbtStatus.value = true;
          SuspendResumeModel res =
              await activeSuspendApi(rrbtPackName, false, false);
          isUpdatingRrbtStatus.value = false;
          if (res.statusCode == 'SC0000') {
            activeRrbtButtonName.value =
                (activeRrbtButtonName.value == suspendStr)
                    ? resumeStr
                    : suspendStr;
            rrbtStatus.value =
                (rrbtStatus.value == activeStr) ? suspendStr : activeStr;
            rrbtStatusMessage.value =
                (rrbtStatusMessage.value == yourServiceIsCurrentlyRunningStr)
                    ? yourServiceIsNotCurrentlyRunningStr
                    : yourServiceIsCurrentlyRunningStr;
          } else {
            showSnackBar(message: res.message ?? someThingWentWrongStr.tr);
          }
        },
      ),
    );
  }

  unSubscribeRrbtStatusAction() async {
    printCustom("unSubscribeRrbtStatusAction");
    Get.dialog(
      CustomConfirmAlertView(
        message: unSubscribeConfirmMessageStr.tr,
        cancelTitle: cancelStr.tr,
        onOk: () async {
          isUpdatingRrbtStatus.value = true;
          await Future.delayed(const Duration(seconds: 2));
          isUpdatingRrbtStatus.value = false;
        },
      ),
    );
  }
}
