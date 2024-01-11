import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_confirm_alert_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/delete_my_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_dedicated_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_my_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_playing_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/my_tune_playing_vm.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/main.dart';

class MyTuneController extends GetxController {
  RxBool isLoadingPlaying = false.obs;
  RxBool isLoadingTune = false.obs;
  RxBool isChangeSuffle = false.obs;
  RxBool isSuffle = false.obs;
  RxBool switchEnabled = false.obs;
  RxString message = ''.obs;

  RxList<ListToneApk> playingList = <ListToneApk>[].obs;
  RxList<ListToneApk1> tuneList = <ListToneApk1>[].obs;
  bool loadingData = false;
  getPlayingTuneList() async {
    if (loadingData) {
      return;
    }
    delay();
    loadingData = true;
    isLoadingPlaying.value = true;
    isLoadingTune.value = true;
    playingList.value = <ListToneApk>[];
    bool status = await getPackStatus();
    if (status) {
      getMyPlayingList();
      getTuneList();
    } else {
      isLoadingPlaying.value = false;
      isLoadingTune.value = false;
      notActiveSubscriberPopup();
    }
    isLoadingPlaying.value = false;
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 600));
    loadingData = false;
    return;
  }

  void notActiveSubscriberPopup() {
    if (!(Get.isDialogOpen ?? true)) {
      Get.dialog(CustomAlertView(
        title: notActiveSubscriberMessageStr,
        onConfirm: () {
          goRouterContext?.go(homeGoRoute);
        },
      ));
    }
  }

  Future<bool> getPackStatus() async {
    PackStatusModel mo = await getPackStatusApiCall(isCrbt: true);
    if (mo.statusCode == "SC0000") {
      return (mo.responseMap?.packStatusDetails?.packName != null);
    } else {
      return false;
    }
  }

  Future<void> getMyPlayingList() async {
    PlayingTuneModel? playingTune =
        await MyTunePlayingVM().getPlayingTuneListApiCall();
    print("called shiv");
    if (playingTune != null) {
      printCustom("Is suffle status 1 ${playingTune.isSuffle!}");
      isSuffle.value = playingTune.isSuffle!;
      switchEnabled.value = playingTune.isSuffle!;
      playingList.value = playingTune.responseMap?.listToneApk ?? [];
    }
    isLoadingPlaying.value = false;
    return;
  }

  Future<void> getTuneList() async {
    tuneList.value = <ListToneApk1>[];

    Map<String, dynamic>? re = await ServiceCall()
        .get('$getMyTuneListUrl&msisdn=${StoreManager().msisdn}');
    if (re != null) {
      MyTuneListModel model = MyTuneListModel.fromJson(re);
      tuneList.value = model.responseMap?.listToneApk ?? [];
      printCustom(
          "============== res ============ ${model.responseMap?.listToneApk}");
    }

    printCustom("getTuneList  ${tuneList.length}");
    isLoadingTune.value = false;
    return;
  }

  Future<void> suffleTune() async {
    isChangeSuffle.value = true;
    var result = await MyTunePlayingVM().suffleTune(!switchEnabled.value);
    isChangeSuffle.value = false;

    if (result != null) {
      MyTuneListModel model = MyTuneListModel.fromJson(result);
      if (model.statusCode == "SC0000") {
        isLoadingPlaying.value = true;
        isChangeSuffle.value = false;
        switchEnabled.value = !switchEnabled.value;
        isSuffle.value = switchEnabled.value;
        await getMyPlayingList();
        isLoadingPlaying.value = false;
      } else {
        showSnackBar(message: model.message ?? someThingWentWrongStr.tr);
      }
    }
  }

//========================================================
  Future<bool> deletePlayingTune(
      String toneId, int index, BuildContext context) async {
    Map<String, dynamic>? resp;
    printCustom(
        "Delete playing tune name ${toneId} ===== ${playingList[index].msisdnB}");
    printCustom("Does contain msisdn ===== ${playingList[index].msisdnB}");

    if (playingList[index].msisdnB == null) {
      bool isFullday = (playingList[index].toneDetails?.first.weeklyDays == "0")
          ? true
          : false;

      print(
          "toneDetails?.first.weeklyDays ${playingList[index].toneDetails?.first.weeklyDays}");
      resp = await deletePlayingTuneApiCall(
          toneId, isFullday ? "2" : '2', isFullday);
    } else {
      printCustom("Delete dedicate tune ");
      resp = await deleteDedicatedTuneApiCall(toneId,
          playingList[index].msisdnB ?? '', playingList[index].timeType ?? '');
    }

    printCustom("Response is =========== ${resp}");

    if (resp != null) {
      DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(resp);
      printCustom("Delete playing tune ${result}");
      if (result.statusCode == "SC0000") {
        playingList.removeAt(index);
      }

      message.value = result.message ?? someThingWentWrongStr;

      return true;
    }

    return false;
  }

  Future<bool> deleteMyTune(String toneId, int index) async {
    printCustom("Delete My tune tune ");

    Get.dialog(CustomConfirmAlertView(
      message: areYouSureYouWantToDeleteStr.tr,
      cancelTitle: callersStr.tr,
      onOk: () async {
        PackStatusModel model = await getPackStatusApiCall();

        if (model.statusCode == 'SC0000') {
          String packName =
              model.responseMap?.packStatusDetails?.packName ?? '';
          var respo = await deleteMyTuneApiCall(toneId, packName);
          //MyTuneService().deleteMyTune(toneId, packName);
          if (respo != null) {
            DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(respo);
            printCustom("Delete My tune tune ${result}");
            message.value = result.message ?? '';
            showSnackBar(message: message.value);
            if (result.statusCode == "SC0000") {
              tuneList.removeAt(index);
            }

            return true;
          }
          return false;
        }
      },
    ));
    return false;
  }
}
