import 'dart:math';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

class TuneSettingDedicatedVM {
  Future<Map<String, dynamic>?> dedicatedFullday(String toneId,
      String dedicatedMsisdn, String packName, String selectedDays) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _dedicatedFulldayParams(
        randomNumber, toneId, dedicatedMsisdn, packName, selectedDays);
    return await _commomMethod(dedicatedTuneSetUrl, params);
  }

  Map<String, dynamic> _dedicatedFulldayParams(int randomNumber, String toneId,
      String dedicatedMsisdn, String packName, String selectedDays) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'bPartyMsisdn': dedicatedMsisdn,
      'serviceId': '13',
      'activityId': '1',
      'packName': packName,
      'timeType': '2',
      'weeklyDays': selectedDays.isEmpty ? '0' : selectedDays,
      'weeklyStartTime': '00:00',
      'weeklyEndTime': '23:59'
    };
  }

  Future<Map<String, dynamic>?> dedicatedTimeBase(
      String toneId,
      String dedicatedMsisdn,
      String packName,
      String selectedDays,
      String fromTimeStr,
      String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _dedicatedTimeBaseParams(randomNumber, toneId,
        dedicatedMsisdn, packName, selectedDays, fromTimeStr, toTimeStr);
    return await _commomMethod(dedicatedTuneSetUrl, params);
  }

  Map<String, dynamic> _dedicatedTimeBaseParams(
      int randomNumber,
      String toneId,
      String dedicatedMsisdn,
      String packName,
      String selectedDays,
      String fromTimeStr,
      String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'bPartyMsisdn': dedicatedMsisdn,
      'serviceId': '13',
      'activityId': '1',
      'packName': packName,
      'timeType': '2',
      'weeklyDays': selectedDays.isEmpty ? '0' : selectedDays,
      'weeklyStartTime': fromTimeStr,
      'weeklyEndTime': toTimeStr
    };
  }

  Future<Map<String, dynamic>?> dedicatedNone(
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _dedicatedNoneParams(randomNumber, toneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(dedicatedTuneSetUrl, params);
  }

  Map<String, dynamic> _dedicatedNoneParams(
      int randomNumber,
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'bPartyMsisdn': dedicatedMsisdn,
      'serviceId': '13',
      'activityId': '1',
      'packName': packName,
      'timeType': '7',
      'customizeStartDate': "${fromTD!.year}-${fromTD.month}-${fromTD.day}",
      'customizeEndDate': "${toTD!.year}-${toTD.month}-${toTD.day}",
      'customizeStartTime': fromTimeStr,
      'customizeEndTime': toTimeStr,
    };
  }

  Future<Map<String, dynamic>?> dedicatedMonthly(
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _dedicatedMonthlyParams(randomNumber, toneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(dedicatedTuneSetUrl, params);
  }

  Map<String, dynamic> _dedicatedMonthlyParams(
      int randomNumber,
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'bPartyMsisdn': dedicatedMsisdn,
      'serviceId': '13',
      'activityId': '1',
      'packName': packName,
      'timeType': '3',
      'startDayMonthly': "${fromTD!.day}",
      'endDayMonthly': "${toTD!.day}",
      'monthlyStartTime': fromTimeStr,
      'monthlyEndTime': toTimeStr,
    };
  }

  Future<Map<String, dynamic>?> dedicatedYearly(
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = _dedicatedYearlyParams(randomNumber, toneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    return await _commomMethod(dedicatedTuneSetUrl, params);
  }

  Map<String, dynamic> _dedicatedYearlyParams(
      int randomNumber,
      String toneId,
      String dedicatedMsisdn,
      String packName,
      DateTime? fromTD,
      DateTime? toTD,
      String fromTimeStr,
      String toTimeStr) {
    return {
      "clientTxnId": '$randomNumber',
      "aPartyMsisdn": StoreManager().msisdn,
      'toneId': toneId,
      'language': StoreManager().languageCode,
      'priority': '0',
      'channelId': channelId,
      'bPartyMsisdn': dedicatedMsisdn,
      'serviceId': '13',
      'activityId': '1',
      'packName': packName,
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
