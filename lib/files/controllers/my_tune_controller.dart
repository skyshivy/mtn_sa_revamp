import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/delete_my_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/my_tunel_list_model.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_dedicated_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_my_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_playing_tune_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/my_tune_playing_vm.dart';

class MyTuneController extends GetxController {
  RxBool isLoadingPlaying = false.obs;
  RxBool isLoadingTune = false.obs;
  RxBool isChangeSuffle = false.obs;
  RxBool isSuffle = false.obs;
  RxBool switchEnabled = false.obs;
  RxString message = ''.obs;

  RxList<ListToneApk> playingList = <ListToneApk>[].obs;
  RxList<ListToneApk1> tuneList = <ListToneApk1>[].obs;

  getPlayingTuneList() async {
    isLoadingPlaying.value = true;
    playingList.value = <ListToneApk>[];
    getTuneList();
    PlayingTuneModel? playingTune =
        await MyTunePlayingVM().getPlayingTuneListApiCall();

    if (playingTune != null) {
      print("Is suffle status 1 ${playingTune.isSuffle!}");
      isSuffle.value = playingTune.isSuffle!;
      switchEnabled.value = playingTune.isSuffle!;
      playingList.value = playingTune.responseMap?.listToneApk ?? [];
    }
    isLoadingPlaying.value = false;
  }

  getTuneList() async {
    tuneList.value = <ListToneApk1>[];
    isLoadingTune.value = true;
    Map<String, dynamic>? re = await ServiceCall().get(getMyTuneListUrl);
    if (re != null) {
      MyTuneListModel model = MyTuneListModel.fromJson(re);
      tuneList.value = model.responseMap?.listToneApk ?? [];
      print(
          "============== res ============ ${model.responseMap?.listToneApk}");
    }

    print("getTuneList  ${tuneList.length}");
    isLoadingTune.value = false;
  }

  Future<void> suffleTune() async {
    isChangeSuffle.value = true;
    var result = await MyTunePlayingVM().suffleTune(!switchEnabled.value);
    isChangeSuffle.value = false;
    switchEnabled.value = !switchEnabled.value;
    isSuffle.value = switchEnabled.value;
  }

//========================================================
  Future<bool> deletePlayingTune(
      String toneId, int index, BuildContext context) async {
    Map<String, dynamic>? resp;
    print(
        "Delete playing tune name ${toneId} ===== ${playingList[index].msisdnB}");
    print("Does contain msisdn ===== ${playingList[index].msisdnB}");
    if (playingList[index].msisdnB == null) {
      bool isFullday = (playingList[index].playAt == "FullDay") ||
          (playingList[index].playAt == "Full Day");
      Map<String, dynamic>? map1 = await deletePlayingTuneApiCall(
          toneId, playingList[index].timeType ?? '', isFullday);
      if (map1 != null) {
        DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(map1);
        if (result.statusCode == 'SC0000') {
          playingList.removeAt(index);
        }
        showSnackBar(message: result.message ?? someThingWentWrongStr);
      }
    } else {
      print("Delete dedicate tune ");
      Map<String, dynamic>? map2 = await deleteDedicatedTuneApiCall(toneId,
          playingList[index].msisdnB ?? '', playingList[index].timeType ?? '');
      if (map2 != null) {
        DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(map2);
        if (result.statusCode == 'SC0000') {
          playingList.removeAt(index);
        }
        showSnackBar(message: result.message ?? someThingWentWrongStr);
      }
    }

    print("Response is =========== ${resp}");

    if (resp != null) {
      DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(resp);
      print("Delete playing tune ${result}");
      playingList.removeAt(index);
      message.value = result.message ?? someThingWentWrongStr;

      return true;
    }

    return false;
  }

  Future<bool> deleteMyTune(String toneId, int index) async {
    print("Delete My tune tune ");
    PackStatusModel model = await getPackStatusApiCall();

    if (model.statusCode == 'SC0000') {
      String packName = model.responseMap?.packStatusDetails?.packName ?? '';
      var respo = await deleteMyTuneApiCall(toneId, packName);
      //MyTuneService().deleteMyTune(toneId, packName);
      if (respo != null) {
        DeleteMyTuneModel result = DeleteMyTuneModel.fromJson(respo);
        print("Delete My tune tune $result");
        message.value = result.message ?? '';
        showSnackBar(message: message.value);
        if (result.statusCode == 'SC0000') {
          tuneList.removeAt(index);
        }

        return true;
      }
      return false;
    }
    return false;
  }
}
