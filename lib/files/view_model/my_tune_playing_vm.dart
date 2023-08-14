import 'dart:convert';
import 'dart:io';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/playing_tune_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MyTunePlayingVM {
  Future<PlayingTuneModel?> getPlayingTuneList() async {
    List<ListToneApk> playingList = <ListToneApk>[];
    bool switchEnabled = false;
    Map<String, dynamic>? result = await ServiceCall().get(getPlayingTunesUrl);
    if (result != null) {
      PlayingTuneModel? playing = await MyTunePlayingVM().getPlayingTuneList();
      if (playing != null) {
        print("Total get in list ${playing.responseMap?.listToneApk?.length}");
        //playingList = playing.responseMap?.listToneApk ?? [];
        var tempPlayingList = <ListToneApk>[];
        if (playing.responseMap?.listToneApk != null ||
            (playing.responseMap?.listToneApk?.isNotEmpty ?? true)) {
          _checkSuffleStatus(playing, switchEnabled);
          tempPlayingList = playing.responseMap!.listToneApk ?? [];
          playingList.removeAt(0);

          List<ListToneApk> list =
              await createPlayingList(tempPlayingList, playingList);
          PlayingTuneModel model = PlayingTuneModel(
              isSuffle: switchEnabled,
              responseMap: ResponseMap(listToneApk: list));
          return model;
        }
        PlayingTuneModel model = PlayingTuneModel(
            isSuffle: switchEnabled,
            responseMap: ResponseMap(listToneApk: <ListToneApk>[]));
        print(
            "Total get in list sorted ${model.responseMap?.listToneApk?.length}");
        return model;
      }
    } else {
      return null;
    }
    return null;
  }

  Future<List<ListToneApk>> createPlayingList(
      List<ListToneApk> tempPlayingList, List<ListToneApk> playingList) async {
    for (ListToneApk info in tempPlayingList) {
      ToneDetail? tD = info.toneDetails?.first;
      bool isFullDay = true;
      createPlayingList1(isFullDay, info, tD, playingList);
    }
    await Future.delayed(const Duration(milliseconds: 300));
    return playingList;
  }

  void _checkSuffleStatus(PlayingTuneModel? playing, bool switchEnabled) {
    if ((playing?.responseMap?.listToneApk!.length)! > 1) {
      for (ListToneApk ind in playing?.responseMap?.listToneApk ?? []) {
        if (ind.callerType == "AllCaller") {
          switchEnabled = (ind.toneDetails?[0].isShuffle) == "T" ? true : false;
        }
      }
    }
  }

  void createPlayingList1(bool isFullDay, ListToneApk info, ToneDetail? tD,
      List<ListToneApk> playingList) {
    _fulldayCheck(isFullDay, info, tD, playingList);
    _yearlyCheck(tD, isFullDay, info, playingList);
    _monthlyCheck(tD, isFullDay, info, playingList);
    _noneCheck(tD, isFullDay, info, playingList);
    _weeklyCheck(tD, isFullDay, info, playingList);
  }

  void _fulldayCheck(bool isFullDay, ListToneApk info, ToneDetail? tD,
      List<ListToneApk> playingList) {
    if (isFullDay) {
      isFullDay = false;
      info.sTime =
          "${tD?.customiseStartTime?.substring(0, tD.customiseStartTime!.length - 3)}"; //${tD?.customiseStartTime}";
      info.eTime =
          "${tD?.customiseEndTime?.substring(0, tD.customiseEndTime!.length - 3)}";
      if (info.status != "P") {
        playingList.add(newDetail(
            info, TimeType.fullDay, "", info.sTime!, info.eTime!,
            isFullday: true));
      }
      print("FullDay");
    }
  }

  _weeklyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
      List<ListToneApk> playingList) {
    if (tD?.weeklyDays != "0") {
      isFullDay = false;
      info.sTime =
          "${tD?.startTimeWeekly?.substring(0, tD.startTimeWeekly!.length - 3)}"; //${tD?.customiseStartTime}";
      info.eTime =
          "${tD?.endTimeWeekly?.substring(0, tD.endTimeWeekly!.length - 3)}";
      if (info.status != "P") {
        playingList.add(
            newDetail(info, TimeType.weekDay, "2", info.sTime!, info.eTime!));
      }
      print("WeekDay");
    }
  }

  _noneCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
      List<ListToneApk> playingList) {
    if ((!(tD?.customiseStartDate == '0')) ||
        (!(tD?.customiseEndDate == '0'))) {
      isFullDay = false;
      info.sTime =
          "${tD?.customiseStartDate} \n${tD?.customiseStartTime?.substring(0, tD.customiseStartTime!.length - 3)}"; //${tD?.customiseStartTime}";
      info.eTime =
          "${tD?.customiseEndDate}\n${tD?.customiseEndTime?.substring(0, tD.customiseEndTime!.length - 3)}";
      if (info.status != "P") {
        playingList
            .add(newDetail(info, TimeType.none, "7", info.sTime!, info.eTime!));
      }
      print("None");
    }
  }

  _monthlyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
      List<ListToneApk> playingList) {
    if (!(tD?.startDayMonthly == '0') || (!(tD?.endDayMonthly == '0'))) {
      isFullDay = false;

      info.sTime =
          "${tD?.startDayMonthly}th Day\n${tD?.startTimeMonthly?.substring(0, tD.startTimeMonthly!.length - 3)}"; //${tD?.startTimeMonthly}";
      info.eTime =
          "${tD?.endDayMonthly}th Day\n${tD?.endTimeMonthly?.substring(0, tD.endTimeMonthly!.length - 3)}"; //${tD?.endTimeMonthly}";
      if (info.status != "P") {
        playingList.add(
            newDetail(info, TimeType.monthly, "3", info.sTime!, info.eTime!));
      }
      print("Monthly");
    }
  }

  _yearlyCheck(ToneDetail? tD, bool isFullDay, ListToneApk info,
      List<ListToneApk> playingList) {
    if (!(tD?.yearlyStartMonth == '0') || (!(tD?.yearlyEndMonth == '0'))) {
      isFullDay = false;
      info.sTime =
          "${tD?.yearlyStartDay}/${tD?.yearlyStartMonth}\n${tD?.yearlyStartTime?.substring(0, tD.yearlyStartTime!.length - 3)}"; //${tD?.yearlyStartTime}";
      info.eTime =
          "${tD?.yearlyEndDay}/${tD?.yearlyEndMonth}\n${tD?.yearlyEndTime?.substring(0, tD.yearlyEndTime!.length - 3)}"; //${tD?.yearlyEndTime}";
      if (info.status != "P") {
        playingList.add(
            newDetail(info, TimeType.yearly, "4", info.sTime!, info.eTime!));
      }

      print("Yearly");
    }
  }

  newDetail(ListToneApk info, TimeType toneDetailTimeType, String timeType,
      String sTime, String eTime,
      {bool isFullday = false}) {
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
}
