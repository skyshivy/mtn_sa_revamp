import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/buy_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/edit_profile.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';

import 'package:mtn_sa_revamp/files/model/profile_model.dart';
import 'package:mtn_sa_revamp/files/model/suspend_resume_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

import 'package:mtn_sa_revamp/files/view_model/active_suspend_api.dart';
import 'package:mtn_sa_revamp/files/view_model/deactivate_pack_api.dart';

import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/profile_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/set_tune_vm.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool editEnable = false.obs;
  RxBool isHideCRBTStatus = false.obs;
  RxBool isHideRRBTStatus = false.obs;
  RxString userName = ''.obs;
  RxBool isSaving = false.obs;

  RxString rrbtSubscriptionButtonName = ''.obs;
  RxString crbtSubscriptionButtonName = ''.obs;
  //RxString packName = ''.obs;

  RxBool isHideCrbtActiveSuspendButton = false.obs;
  RxBool isHideRrbtActiveSuspendButton = false.obs;
  RxString crbtPackName = ''.obs;
  RxString rrbtPackName = ''.obs;
  bool _isCrbtSuspendMode = false;
  bool _isRrbtSuspendMode = false;
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
  bool stopMultipleApiCall = true;
  RxBool updatingProfilePage = false.obs;
  RxList<AppCategory> catList = <AppCategory>[].obs;

  getPref() async {
    // var result = await ServiceCall().get(categoryListUrl);

    // if (result != null) {
    //   CategoryModel model = CategoryModel.fromJson(result);
    //   catList.value = model.responseMap?.categories ?? [];
    //   print("category is ${catList.length}");
    // }
  }

  Future<void> getCrbtPackStatus() async {
    PackStatusModel? packStatusModel =
        await getPackStatusApiCall(StoreManager().msisdn, isCrbt: true);
    print("getCrbtPackStatus resp message is = ${packStatusModel.message}");
    print("getCrbtPackStatus resp message is = ${packStatusModel.statusCode}");
    if (packStatusModel.statusCode == 'SC0000') {
      // isHideCRBTStatus.value =
      //     !(packStatusModel.responseMap?.packStatusDetails?.packName != null);
      bool isPackName =
          packStatusModel.responseMap?.packStatusDetails?.packName == null;
      isHideCrbtActiveSuspendButton.value =
          (packStatusModel.responseMap?.packStatusDetails?.packName == null);
      crbtPackName.value =
          (packStatusModel.responseMap?.packStatusDetails?.packName ?? '');
      activeCrbtButtonName.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? activateStr.tr
              : suspendStr.tr;
      crbtTuneStatusMessage.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? yourServiceIsNotCurrentlyRunningStr
              : yourServiceIsCurrentlyRunningStr;
      crbtTuneStatus.value = activeStr.tr;
      crbtSubscriptionButtonName.value = unSubscribeStr.tr;
      _isRrbtSuspendMode = false;
      if (isPackName) {
        crbtTuneStatus.value = '';
        crbtTuneStatusMessage.value = '';
        crbtTuneStatus.value = inActiveStr.tr;
        crbtSubscriptionButtonName.value = subscribeStr.tr;
      }
      return;
    } else if (packStatusModel.statusCode == 'FL0014') {
      _isRrbtSuspendMode = true;
      activeCrbtButtonName.value = activateStr.tr;
      crbtTuneStatusMessage.value = yourServiceIsNotCurrentlyRunningStr;
      isHideCRBTStatus.value = false;
      crbtTuneStatus.value = suspendStr.tr;
      crbtSubscriptionButtonName.value = unSubscribeStr.tr;
    } else {
      _isRrbtSuspendMode = false;
      crbtPackName.value = '';
      crbtSubscriptionButtonName.value = subscribeStr.tr;
      //isHideCRBTStatus.value = true;
      return;
    }
  }

  Future<BuyTuneModel> setCrbtTune() async {
    Others? other = StoreManager().appSetting?.responseMap?.settings?.others;
    String toneid = other?.defaultTone?.attribute ?? '';
    TuneInfo info = TuneInfo(toneId: toneid, toneName: 'DEFAULT');
    BuyTuneModel model = await SetTuneVM().set(info, 'CRBT_WEEKLY', '0');

    return model;
  }

  Future<BuyTuneModel> setRrbtTune() async {
    //offer code
    // default tone id
    Others? other = StoreManager().appSetting?.responseMap?.settings?.others;
    String toneid = other?.defaultTone?.attribute ?? '';
    TuneInfo info = TuneInfo(toneId: toneid, toneName: "DEFAULT");
    BuyTuneModel model = await SetTuneVM().set(info, 'RRBT_WEEKLY', '1');

    return model;
  }

  Future<void> getRrbtPackStatus() async {
    PackStatusModel? packStatusModel =
        await getPackStatusApiCall(StoreManager().msisdn, isCrbt: false);
    print("getCrbtPackStatus resp message is = ${packStatusModel.message}");
    print("getCrbtPackStatus resp message is = ${packStatusModel.statusCode}");
    if (packStatusModel.statusCode == 'SC0000') {
      // isHideRRBTStatus.value =
      //     !(packStatusModel.responseMap?.packStatusDetails?.packName != null);
      bool isPackName =
          packStatusModel.responseMap?.packStatusDetails?.packName == null;

      rrbtPackName.value =
          packStatusModel.responseMap?.packStatusDetails?.packName ?? '';
      activeRrbtButtonName.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? activateStr.tr
              : suspendStr.tr;
      rrbtStatusMessage.value =
          (packStatusModel.responseMap?.packStatusDetails == null)
              ? yourServiceIsNotCurrentlyRunningStr
              : yourServiceIsCurrentlyRunningStr;
      rrbtStatus.value = activeStr.tr;
      rrbtSubscriptionButtonName.value = unSubscribeStr.tr;
      isHideRrbtActiveSuspendButton.value =
          (packStatusModel.responseMap?.packStatusDetails?.packName == null);
      _isCrbtSuspendMode = false;
      if (isPackName) {
        rrbtStatusMessage.value = '';
        rrbtStatus.value = '';
        rrbtStatus.value = inActiveStr.tr;
        rrbtSubscriptionButtonName.value = subscribeStr.tr;
      }
      return;
    } else if (packStatusModel.statusCode == 'FL0014') {
      _isCrbtSuspendMode = true;
      rrbtStatus.value = suspendStr.tr;
      activeRrbtButtonName.value = activateStr.tr;
      rrbtSubscriptionButtonName.value = unSubscribeStr.tr;
      rrbtStatusMessage.value = yourServiceIsNotCurrentlyRunningStr;
      isHideRRBTStatus.value = false;
    } else {
      _isCrbtSuspendMode = false;
      rrbtPackName.value = '';
      rrbtSubscriptionButtonName.value = subscribeStr.tr;
      //isHideRRBTStatus.value = true;
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
    if (!stopMultipleApiCall) {
      await Future.delayed(const Duration(milliseconds: 100));
      stopMultipleApiCall = true;
      print("prevented getProfileDetail called multiple");
      return;
    }
    print("prevented getProfileDetail called multiple");
    stopMultipleApiCall = false;
    selectedCatList.clear();
    isLoading.value = true;
    //await ServiceCall().regenarateTokenFromOtherClass();
    await getPref();
    await _packApiCalls();
    // await getCrbtPackStatus();
    // await getRrbtPackStatus();

    // checkHideAndUnhide();
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

  Future<void> _packApiCalls() async {
    updatingProfilePage.value = true;
    await Future.delayed(const Duration(seconds: 2));
    await getCrbtPackStatus();
    await getRrbtPackStatus();
    checkHideAndUnhide();
    updatingProfilePage.value = false;
    return;
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
                    ? activateStr
                    : suspendStr;
            crbtTuneStatus.value =
                (crbtTuneStatus.value == activeStr) ? suspendStr : activeStr;
            crbtTuneStatusMessage.value = (crbtTuneStatusMessage.value ==
                    yourServiceIsCurrentlyRunningStr)
                ? yourServiceIsNotCurrentlyRunningStr
                : yourServiceIsCurrentlyRunningStr;
            _packApiCalls();
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
                    ? activateStr
                    : suspendStr;
            crbtTuneStatus.value =
                (crbtTuneStatus.value == activeStr) ? suspendStr : activeStr;
            crbtTuneStatusMessage.value = (crbtTuneStatusMessage.value ==
                    yourServiceIsCurrentlyRunningStr)
                ? yourServiceIsNotCurrentlyRunningStr
                : yourServiceIsCurrentlyRunningStr;
            _packApiCalls();
          } else {
            showSnackBar(message: res.message ?? someThingWentWrongStr.tr);
          }
        },
      ),
    );
    printCustom("activeTuneStatusAction");
  }

  unsubscribeCrbtTuneStatusAction() async {
    if (_isCrbtSuspendMode) {
      Get.dialog(
        CustomAlertView(title: pleaseActivateToUnsubscribeStr.tr),
      );
      return;
    }
    printCustom("unsubscribeCrbtTuneStatusAction");
    if (crbtSubscriptionButtonName.value == subscribeStr.tr) {
      isUpdatingCrbtStatus.value = true;
      BuyTuneModel model = await setCrbtTune();
      if (model.statusCode == "SC0000") {
        rrbtSubscriptionButtonName.value = unSubscribeStr.tr;
        _packApiCalls();
      }
      isUpdatingCrbtStatus.value = false;
    } else {
      Get.dialog(
        CustomConfirmAlertView(
          message: unSubscribeConfirmMessageStr.tr,
          cancelTitle: cancelStr.tr,
          onOk: () async {
            isUpdatingCrbtStatus.value = true;
            //await deleteMyTuneApiCall("0", crbtPackName.value);
            PackStatusModel mod =
                await deactivatePackApi(crbtPackName.value, true);
            if (mod.statusCode == "SC0000") {
              _packApiCalls();
            } else {
              showSnackBar(message: mod.message ?? someThingWentWrongStr.tr);
            }
            //await Future.delayed(const Duration(seconds: 2));
            isUpdatingCrbtStatus.value = false;
          },
        ),
      );
    }
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
              await activeSuspendApi(rrbtPackName.value, true, false);
          isUpdatingRrbtStatus.value = false;
          if (res.statusCode == 'SC0000') {
            activeRrbtButtonName.value =
                (activeRrbtButtonName.value == suspendStr)
                    ? activateStr
                    : suspendStr;
            rrbtStatus.value =
                (rrbtStatus.value == activeStr) ? suspendStr : activeStr;
            rrbtStatusMessage.value =
                (rrbtStatusMessage.value == yourServiceIsCurrentlyRunningStr)
                    ? yourServiceIsNotCurrentlyRunningStr
                    : yourServiceIsCurrentlyRunningStr;
            _packApiCalls();
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
              await activeSuspendApi(rrbtPackName.value, false, false);
          isUpdatingRrbtStatus.value = false;
          if (res.statusCode == 'SC0000') {
            _packApiCalls();
            activeRrbtButtonName.value =
                (activeRrbtButtonName.value == suspendStr)
                    ? activateStr
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
    if (_isRrbtSuspendMode) {
      Get.dialog(Center(
        child: CustomAlertView(title: pleaseActivateToUnsubscribeStr.tr),
      ));
      return;
    }
    if (rrbtSubscriptionButtonName.value == subscribeStr.tr) {
      isUpdatingRrbtStatus.value = true;
      BuyTuneModel model = await setRrbtTune();
      if (model.statusCode == "SC0000") {
        rrbtSubscriptionButtonName.value = unSubscribeStr.tr;
        _packApiCalls();
      }
      isUpdatingRrbtStatus.value = false;
    } else {
      Get.dialog(
        CustomConfirmAlertView(
          message: unSubscribeConfirmMessageStr.tr,
          cancelTitle: cancelStr.tr,
          onOk: () async {
            isUpdatingRrbtStatus.value = true;
            PackStatusModel mod =
                await deactivatePackApi(rrbtPackName.value, false);
            if (mod.statusCode == 'SC0000') {
              _packApiCalls();
            } else {
              showSnackBar(message: mod.message ?? someThingWentWrongStr.tr);
            }
            //deleteMyTuneApiCall("0", rrbtPackName);
            //await Future.delayed(const Duration(seconds: 2));
            isUpdatingRrbtStatus.value = false;
          },
        ),
      );
    }
  }
}
