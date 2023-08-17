import 'dart:math';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class TuneSettingAllCallerVM {
  Future<Map<String, dynamic>?> setAllCallerFullDay(
      String toneId, String days) async {
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);
    List<Map<String, dynamic>> toneIdList = [
      {"toneId": toneId}
    ];
    String url = '';
    Map<String, dynamic> params;
    if (days.isEmpty) {
      print("add to suffle api need to call $addToneToSuffleUrl");
      url = addToneToSuffleUrl;
      params = _addToneSuffleParams(randomNumber, toneIdList);
    } else {
      print("Tradition api need to call $timeBaseTuneSetUrl");
      url = timeBaseTuneSetUrl;
      params = _fullDayTuneSetParams(randomNumber, toneId, days);
    }
    return await _commomMethod(url, params);
  }

  Map<String, dynamic> _fullDayTuneSetParams(
      int randomNumber, String toneId, String days) {
    return {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'serviceId': '17',
      'activityId': '1',
      'timeType': '2',
      'weeklyDays': days,
      'weeklyStartTime': '00:00',
      'weeklyEndTime': '23:59'
    };
  }

  Map<String, dynamic> _addToneSuffleParams(
      int randomNumber, List<Map<String, dynamic>> toneIdList) {
    return {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': StoreManager().msisdn,
      'toneIdList': toneIdList,
      'language': StoreManager().languageCode,
      'activityId': '1',
      'priority': '0',
      'serviceId': '1',
      'channelId': channelId,
    };
  }

  Future<Map<String, dynamic>?> allCallerTimeBase(
      String toneId, String days, String sTime, String eTime) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params =
        _allCallerTimeBaseParams(randomNumber, toneId, days, sTime, eTime);
    return await _commomMethod(timeBaseTuneSetUrl, params);
  }

  Map<String, dynamic> _allCallerTimeBaseParams(int randomNumber, String toneId,
      String days, String sTime, String eTime) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'serviceId': '17',
      'activityId': '1',
      'timeType': '2',
      'weeklyDays': days,
      'weeklyStartTime': sTime,
      'weeklyEndTime': eTime,
    };
  }

  Future<Map<String, dynamic>?> allCallerNone(String toneId, DateTime? fromTD,
      DateTime? toTD, String fromTimeStr, String toTimeStr) async {
    var url = timeBaseTuneSetUrl;
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _allCallerNoneParams(
        randomNumber, toneId, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(url, params);
  }

  Map<String, dynamic> _allCallerNoneParams(int randomNumber, String toneId,
      DateTime? fromTD, DateTime? toTD, String fromTimeStr, String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'serviceId': '17',
      'activityId': '1',
      'timeType': '7',
      'customizeStartDate': "${fromTD!.year}-${fromTD.month}-${fromTD.day}",
      'customizeEndDate': "${toTD!.year}-${toTD.month}-${toTD.day}",
      'customizeStartTime': fromTimeStr,
      'customizeEndTime': toTimeStr,
    };
  }

  Future<Map<String, dynamic>?> allCallerMonthly(
      String toneId,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    Map<String, dynamic> params = _allCallerMonthlyParams(
        randomNumber, toneId, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(timeBaseTuneSetUrl, params);
  }

  Map<String, dynamic> _allCallerMonthlyParams(int randomNumber, String toneId,
      DateTime? fromTD, DateTime? toTD, String fromTimeStr, String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'serviceId': '17',
      'activityId': '1',
      'timeType': '3',
      'startDayMonthly': "${fromTD!.day}",
      'endDayMonthly': "${toTD!.day}",
      'monthlyStartTime': fromTimeStr,
      'monthlyEndTime': toTimeStr,
    };
  }

  Future<Map<String, dynamic>?> allDayYearly(String toneId, DateTime? fromTD,
      DateTime? toTD, String fromTimeStr, String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _allDayYearlyParams(
        randomNumber, toneId, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(timeBaseTuneSetUrl, params);
  }

  Map<String, dynamic> _allDayYearlyParams(int randomNumber, String toneId,
      DateTime? fromTD, DateTime? toTD, String fromTimeStr, String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'serviceId': '17',
      'activityId': '1',
      'timeType': '4',
      'yearlyStartMonth': "${fromTD!.month}",
      'yearlyEndMonth': "${toTD!.month}",
      'yearlyStartDay': "${fromTD.day}",
      'yearlyEndDay': "${toTD.day}",
      'yearlyStartTime': fromTimeStr,
      'yearlyEndTime': toTimeStr,
    };
  }

  Future<Map<String, dynamic>?> _commomMethod(
      String url, Map<String, dynamic> params) async {
    var parts = [];
    params.forEach((key, value) {
      parts.add('$key=' '$value');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? map = await ServiceCall().post(url, formData);
    return map;
  }
}
