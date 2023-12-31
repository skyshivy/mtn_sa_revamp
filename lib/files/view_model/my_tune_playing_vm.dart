import 'dart:math';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MyTunePlayingVM {
  Future<PlayingTuneModel?> getPlayingTuneListApiCall() async {
    List<ListToneApk> playingList = <ListToneApk>[];
    bool switchEnabled = false;
    Map<String, dynamic>? result = await ServiceCall().get(getPlayingTunesUrl);

    if (result != null) {
      PlayingTuneModel? playing = PlayingTuneModel.fromJson(result);

      var tempPlayingList = <ListToneApk>[];
      if (playing.responseMap?.listToneApk != null ||
          (playing.responseMap?.listToneApk?.isNotEmpty ?? true)) {
        if ((playing.responseMap?.listToneApk!.length)! > 1) {
          for (ListToneApk ind in playing.responseMap?.listToneApk ?? []) {
            print("AllCaller=== ${ind.serviceName}");
            if (ind.serviceName == "AllCaller") {
              print("Suffle is enabled");

              print("Is suffle status 3 ${ind.toneDetails?[0].isShuffle}");
              switchEnabled =
                  (ind.toneDetails?[0].isShuffle) == "T" ? true : false;
            }
          }
        }
        tempPlayingList = playing.responseMap!.listToneApk ?? [];
        tempPlayingList.removeAt(0);
        print("Total get in list ${tempPlayingList.length}");
        print("Test 1");
        List<ListToneApk> list =
            await createPlayingList(tempPlayingList, playingList);
        print("Test 11");
        PlayingTuneModel model = PlayingTuneModel(
            isSuffle: switchEnabled,
            responseMap: ResponseMap(listToneApk: list));
        print("Total get in list sorted new ${list.length}");
        return model;
      }
      PlayingTuneModel model = PlayingTuneModel(
          isSuffle: switchEnabled,
          responseMap: ResponseMap(listToneApk: <ListToneApk>[]));
      print(
          "Total get in list sorted ${model.responseMap?.listToneApk?.length}");
      return model;
    } else {
      return null;
    }
  }

  Future<List<ListToneApk>> createPlayingList(
      List<ListToneApk> tempPlayingList, List<ListToneApk> playingList) async {
    playingList.clear();
    print("Test 2");
    for (ListToneApk info in tempPlayingList) {
      print("createPlayingList ++++++++++");
      ToneDetail? tD = info.toneDetails?.first;
      bool isFullDay = true;
      await createPlayingList1(isFullDay, info, tD, playingList);
    }
    print("Test 3  items are ${playingList.length}");
    await Future.delayed(const Duration(milliseconds: 300));
    print("Test 4");
    return playingList;
  }

  Future<Map<String, dynamic>?> suffleTune(bool activate) async {
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);
    print(" randomNumber data is = 123");
    Map<String, dynamic> params = {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': StoreManager().msisdn,
      'identifier': activate ? 'activate' : 'deactivate',
      'language': StoreManager().languageCode,
    };
    var parts = [];
    params.forEach((key, value) {
      parts.add('${key}='
          '${value}');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? res =
        await ServiceCall().post(tuneSuffleUrl, formData);
    return res;
  }
}

Future<void> createPlayingList1(bool isFullDay, ListToneApk info,
    ToneDetail? tD, List<ListToneApk> playingList) async {
  await _fulldayCheck(isFullDay, info, tD, playingList);
  await _yearlyCheck(tD, isFullDay, info, playingList);
  await _monthlyCheck(tD, isFullDay, info, playingList);
  await _noneCheck(tD, isFullDay, info, playingList);
  await _weeklyCheck(tD, isFullDay, info, playingList);
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
      playingList.add(await newDetail(
          info, TimeType.fullDay, "", info.sTime!, info.eTime!,
          isFullday: true));
    }
    print("_fulldayCheck");
  }
}

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
    }
    print("_weeklyCheck");
  }
}

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
          await newDetail(info, TimeType.none, "7", info.sTime!, info.eTime!));
    }
    print("_noneCheck");
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
      playingList.add(await newDetail(
          info, TimeType.monthly, "3", info.sTime!, info.eTime!));
    }
    print("_monthlyCheck");
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
      playingList.add(await newDetail(
          info, TimeType.yearly, "4", info.sTime!, info.eTime!));
    }

    print("_yearlyCheck");
  }
}

Future<ListToneApk> newDetail(ListToneApk info, TimeType toneDetailTimeType,
    String timeType, String sTime, String eTime,
    {bool isFullday = false}) async {
  ListToneApk listToneApk = ListToneApk();

  listToneApk.callerType = info.msisdnB ?? info.serviceName;
  listToneApk.status =
      info.toneDetails?.first.isShuffle != null ? shuffleStr : activeStr;
  listToneApk.playAt = isFullday ? fulldayStr : customStr;
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
