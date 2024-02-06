import 'dart:math';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MyTunePlayingVM {
  Future<PlayingTuneModel?> getPlayingTuneListApiCall() async {
    List<ListToneApk> _ = <ListToneApk>[];
    //bool switchEnabled = false;
    Map<String, dynamic>? result = await ServiceCall()
        .get("$getPlayingTunesUrl&msisdn=${StoreManager().msisdn}");
    //===========================================================================
    // to display only Fullday all caller and specific caller added below line
    return await _displayTune(result);
    // to Display for time base, all caller , and specific caller  , comment above line line
//===========================================================================
/*
    if (result != null) {
      PlayingTuneModel? playing = PlayingTuneModel.fromJson(result);
      printCustom("check sky = ${playing.responseMap?.listToneApk?.length}");
      //playingList = playing.responseMap?.listToneApk ?? [];

      var tempPlayingList = <ListToneApk>[];
      if (playing.responseMap?.listToneApk != null ||
          (playing.responseMap?.listToneApk?.isNotEmpty ?? true)) {
        if ((playing.responseMap?.listToneApk!.length)! > 1) {
          for (ListToneApk ind in playing.responseMap?.listToneApk ?? []) {
            printCustom("AllCaller=== ${ind.serviceName}");
            if (ind.serviceName == "AllCaller") {
              printCustom("Suffle is enabled");

              printCustom(
                  "Is suffle status 3 ${ind.toneDetails?[0].isShuffle}");
              switchEnabled =
                  (ind.toneDetails?[0].isShuffle) == "T" ? true : false;
            }
          }
        }
        tempPlayingList = playing.responseMap!.listToneApk ?? [];
        //tempPlayingList.removeAt(0);
        printCustom("Total get in list ${tempPlayingList.length}");

        List<ListToneApk> list =
            await createPlayingList(tempPlayingList, playingList);

        PlayingTuneModel model = PlayingTuneModel(
            isSuffle: switchEnabled,
            responseMap: ResponseMap(listToneApk: list));
        printCustom("Total get in list sorted new ${list.length}");
        return model;
      }
      PlayingTuneModel model = PlayingTuneModel(
          isSuffle: switchEnabled,
          responseMap: ResponseMap(listToneApk: <ListToneApk>[]));
      printCustom(
          "Total get in list sorted ${model.responseMap?.listToneApk?.length}");
      return model;
    } else {
      return null;
    }
    */
  }

  Future<List<ListToneApk>> createPlayingList(
      List<ListToneApk> tempPlayingList, List<ListToneApk> playingList) async {
    playingList.clear();

    for (ListToneApk info in tempPlayingList) {
      if (info.toneDetails?.first != null) {
        printCustom("SKY info.toneDetails ");
        ToneDetail? tD = info.toneDetails?.first;
        bool isFullDay = true;
        await _createPlayingList1(isFullDay, info, tD, playingList);
      } else {
        printCustom(
            "this item has not ToneDetail = ${info.toneDetails?.first}");
      }
    }

    await Future.delayed(const Duration(milliseconds: 300));

    return playingList;
  }

  Future<Map<String, dynamic>?> suffleTune(bool activate) async {
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);
    printCustom(" randomNumber data is = 123");
    Map<String, dynamic> params = {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': StoreManager().msisdn,
      'identifier': activate ? 'activate' : 'deactivate',
      'language': StoreManager().languageCode,
    };
    var parts = [];
    params.forEach((key, value) {
      parts.add('$key='
          '$value');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? res =
        await ServiceCall().post(tuneSuffleUrl, formData);
    return res;
  }
}

Future<void> _createPlayingList1(bool isFullDay, ListToneApk info,
    ToneDetail? tD, List<ListToneApk> playingList) async {
  await _fulldayCheck(isFullDay, info, tD, playingList);
  await _yearlyCheck(tD, isFullDay, info, playingList);
  await _monthlyCheck(tD, isFullDay, info, playingList);
  await _noneCheck(tD, isFullDay, info, playingList);
  //await _weeklyCheck(tD, isFullDay, info, playingList);
}

Future<void> _fulldayCheck(bool isFullDay, ListToneApk info, ToneDetail? tD,
    List<ListToneApk> playingList) async {
  if (isFullDay) {
    isFullDay = false;
    info.sTime =
        "${tD?.customiseStartTime?.substring(0, tD.customiseStartTime!.length - 3)}"; //${tD?.customiseStartTime}";
    info.eTime =
        "${tD?.customiseEndTime?.substring(0, tD.customiseEndTime!.length - 3)}";
    if (info.status != "P") {
      bool isFlDay = ((tD?.weeklyDays ?? "0") == "0") ? true : false;
      playingList.add(await _newDetail(
          info, TimeType.fullDay, "", info.sTime!, info.eTime!,
          isFullday: isFlDay));
    } else {
      printCustom("Staus is pending = ${info.status}");
    }
    //printCustom("_fulldayCheck");
  }
}

/*
Future<void> _weeklyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
    List<ListToneApk> playingList) async {
  if (tD?.weeklyDays != "0") {
    isFullDay = false;
    info.sTime =
        "${tD?.startTimeWeekly?.substring(0, tD.startTimeWeekly!.length - 3)}"; //${tD?.customiseStartTime}";
    info.eTime =
        "${tD?.endTimeWeekly?.substring(0, tD.endTimeWeekly!.length - 3)}";
    if (info.status != "P") {
      
      playingList.add(await newDetail(
          info, TimeType.weekDay, "2", info.sTime!, info.eTime!));
    } else {
      printCustom("Staus is pending = ${info.status}");
    }
    printCustom("_weeklyCheck");
  }
}
*/
Future<void> _noneCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
    List<ListToneApk> playingList) async {
  if ((!(tD?.customiseStartDate == '0')) || (!(tD?.customiseEndDate == '0'))) {
    isFullDay = false;
    info.sTime =
        "${tD?.customiseStartDate} \n${tD?.customiseStartTime?.substring(0, tD.customiseStartTime!.length - 3)}"; //${tD?.customiseStartTime}";
    info.eTime =
        "${tD?.customiseEndDate}\n${tD?.customiseEndTime?.substring(0, tD.customiseEndTime!.length - 3)}";
    if (info.status != "P") {
      playingList.add(
          await _newDetail(info, TimeType.none, "7", info.sTime!, info.eTime!));
    } else {
      printCustom("Staus is pending = ${info.status}");
    }
    // printCustom("_noneCheck");
  }
}

Future<void> _monthlyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
    List<ListToneApk> playingList) async {
  if (!(tD?.startDayMonthly == '0') || (!(tD?.endDayMonthly == '0'))) {
    isFullDay = false;

    info.sTime =
        "${tD?.startDayMonthly}th Day\n${tD?.startTimeMonthly?.substring(0, tD.startTimeMonthly!.length - 3)}"; //${tD?.startTimeMonthly}";
    info.eTime =
        "${tD?.endDayMonthly}th Day\n${tD?.endTimeMonthly?.substring(0, tD.endTimeMonthly!.length - 3)}"; //${tD?.endTimeMonthly}";
    if (info.status != "P") {
      playingList.add(await _newDetail(
          info, TimeType.monthly, "3", info.sTime!, info.eTime!));
    } else {
      printCustom("Staus is pending = ${info.status}");
    }
    //printCustom("_monthlyCheck");
  }
}

Future<void> _yearlyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
    List<ListToneApk> playingList) async {
  if (!(tD?.yearlyStartMonth == '0') || (!(tD?.yearlyEndMonth == '0'))) {
    isFullDay = false;
    info.sTime =
        "${tD?.yearlyStartDay}/${tD?.yearlyStartMonth}\n${tD?.yearlyStartTime?.substring(0, tD.yearlyStartTime!.length - 3)}"; //${tD?.yearlyStartTime}";
    info.eTime =
        "${tD?.yearlyEndDay}/${tD?.yearlyEndMonth}\n${tD?.yearlyEndTime?.substring(0, tD.yearlyEndTime!.length - 3)}"; //${tD?.yearlyEndTime}";
    if (info.status != "P") {
      playingList.add(await _newDetail(
          info, TimeType.yearly, "4", info.sTime!, info.eTime!));
    } else {
      printCustom("Staus is pending = ${info.status}");
    }

    //printCustom("_yearlyCheck");
  }
}

Future<ListToneApk> _newDetail(ListToneApk info, TimeType toneDetailTimeType,
    String timeType, String sTime, String eTime,
    {bool isFullday = false}) async {
  ListToneApk listToneApk = ListToneApk();

  listToneApk.callerType = info.msisdnB ?? info.serviceName;
  listToneApk.status =
      info.toneDetails?.first.isShuffle != null ? shuffleStr.tr : activeStr.tr;
  listToneApk.playAt = isFullday ? fulldayStr.tr : customStr.tr;
  listToneApk.packUserDetailsCrbt = info.packUserDetailsCrbt;
  listToneApk.serviceName = info.serviceName;
  listToneApk.groupId = info.groupId;
  listToneApk.toneDetails = info.toneDetails;
  listToneApk.msisdnB = info.msisdnB;
  listToneApk.toneDetailTimeType = toneDetailTimeType;
  listToneApk.timeType = timeType;
  listToneApk.sTime = sTime;
  listToneApk.eTime = eTime;
  listToneApk.customServiceName = info.customServiceName;
  return listToneApk;
}

//========================================================
Future<PlayingTuneModel?> _displayTune(Map<String, dynamic>? result) async {
  List<ListToneApk> lst = [];
  List<ListToneApk> rrbtList = [];
  bool switchEnabled = false;
  if (result != null) {
    PlayingTuneModel? playing = PlayingTuneModel.fromJson(result);
    if (playing.statusCode == "SC0000") {
      List<ListToneApk> tempListToneApkList =
          playing.responseMap?.listToneApk ?? [];
      for (ListToneApk element in tempListToneApkList) {
        if ((element.serviceName == "SpecialCallerSetting") ||
            (element.serviceName == "AllCaller")) {
          if (element.toneDetails != null) {
            printCustom("===========It is not null");
            ToneDetail? tD = element.toneDetails?.first;

            bool isFlDay = ((tD?.weeklyDays ?? "0") == "0") ? true : false;
            lst.add(await _newDetail(element, TimeType.fullDay, "",
                element.sTime ?? '', element.eTime ?? '',
                isFullday: isFlDay));
          } else {
            printCustom("It is  null");
          }
        } else if ((element.serviceName == "RAllCaller")) {
          if (element.toneDetails != null) {
            ToneDetail? tD = element.toneDetails?.first;

            bool isFlDay = ((tD?.weeklyDays ?? "0") == "0") ? true : false;
            rrbtList.add(await _newDetail(element, TimeType.fullDay, "",
                element.sTime ?? '', element.eTime ?? '',
                isFullday: isFlDay));
          }
        } else {}
      }

      printCustom("Total list =========== ${lst.length}");

      if (playing.responseMap?.listToneApk != null ||
          (playing.responseMap?.listToneApk?.isNotEmpty ?? true)) {
        if ((playing.responseMap?.listToneApk!.length)! > 1) {
          for (ListToneApk ind in playing.responseMap?.listToneApk ?? []) {
            printCustom("AllCaller=== ${ind.serviceName}");
            if (ind.serviceName == "AllCaller") {
              printCustom("Suffle is enabled");
              printCustom(
                  "Is suffle status 3 ${ind.toneDetails?[0].isShuffle}");
              switchEnabled =
                  (ind.toneDetails?[0].isShuffle) == "T" ? true : false;
            }
          }
        }
        PlayingTuneModel model = PlayingTuneModel(
            isSuffle: switchEnabled,
            rrbtResponseMap: ResponseMap(listToneApk: rrbtList),
            responseMap: ResponseMap(listToneApk: lst));
        printCustom("Total get in list sorted new ${lst.length}");
        //for (var element in listToneApkList) {
        printCustom(
            "Total item in model ${model.responseMap?.listToneApk?.length}");
        //printCustom("elements in ${listToneApkList?.packUserDetailsCrbt}");
        return model;
      }
    }
  }

  printCustom("SKY info.toneDetails 52");
  return null;
}
