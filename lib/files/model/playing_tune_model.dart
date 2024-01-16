// To parse this JSON data, do
//
//     final playingTuneModel = playingTuneModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';

PlayingTuneModel playingTuneModelFromJson(String str) =>
    PlayingTuneModel.fromJson(json.decode(str));

String playingTuneModelToJson(PlayingTuneModel data) =>
    json.encode(data.toJson());

class PlayingTuneModel {
  ResponseMap? responseMap;
  ResponseMap? rrbtResponseMap;
  String? message;
  String? respTime;
  String? statusCode;
  bool? isSuffle = false;
  PlayingTuneModel({
    this.responseMap,
    this.rrbtResponseMap,
    this.message,
    this.respTime,
    this.statusCode,
    this.isSuffle,
  });

  factory PlayingTuneModel.fromJson(Map<String, dynamic> json) =>
      PlayingTuneModel(
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  List<ListToneApk>? listToneApk;

  ResponseMap({
    this.listToneApk,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        listToneApk: json["listToneApk"] == null
            ? []
            : List<ListToneApk>.from(
                json["listToneApk"]!.map((x) => ListToneApk.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listToneApk": listToneApk == null
            ? []
            : List<dynamic>.from(listToneApk!.map((x) => x.toJson())),
      };
}

class ListToneApk {
  PackUserDetailsCrbt? packUserDetailsCrbt;
  String? serviceName;
  int? groupId;
  List<ToneDetail>? toneDetails;
  String? msisdnB;
  TimeType? toneDetailTimeType;
  String? timeType;
  String? customServiceName;
  bool? isFullDay = false;
  String? sTime;
  String? eTime;
  String? callerType;
  String? playAt;
  String? status;
  ListToneApk(
      {this.packUserDetailsCrbt,
      this.serviceName,
      this.groupId,
      this.toneDetails,
      this.msisdnB});

  ListToneApk.fromJson(Map<String, dynamic> json) {
    packUserDetailsCrbt = json['packUserDetails_Crbt'] != null
        ? new PackUserDetailsCrbt.fromJson(json['packUserDetails_Crbt'])
        : null;
    serviceName = json['serviceName'];
    groupId = json['groupId'];
    if (json['toneDetails'] != null) {
      toneDetails = <ToneDetail>[];
      json['toneDetails'].forEach((v) {
        toneDetails!.add(new ToneDetail.fromJson(v));
      });
    }

    msisdnB = json['msisdnB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packUserDetailsCrbt != null) {
      data['packUserDetails_Crbt'] = this.packUserDetailsCrbt!.toJson();
    }
    data['serviceName'] = this.serviceName;
    data['groupId'] = this.groupId;
    if (this.toneDetails != null) {
      data['toneDetails'] = this.toneDetails!.map((v) => v.toJson()).toList();
    }
    data['msisdnB'] = this.msisdnB;
    return data;
  }
}

class PackUserDetailsCrbt {
  String? isShuffle;
  String? isSuspend;
  String? language;
  String? packExpiry;
  String? packName;
  String? serialNo;
  String? serviceType;

  PackUserDetailsCrbt({
    this.isShuffle,
    this.isSuspend,
    this.language,
    this.packExpiry,
    this.packName,
    this.serialNo,
    this.serviceType,
  });

  factory PackUserDetailsCrbt.fromJson(Map<String, dynamic> json) =>
      PackUserDetailsCrbt(
        isShuffle: json["isShuffle"],
        isSuspend: json["isSuspend"],
        language: json["language"],
        packExpiry: json["packExpiry"],
        packName: json["packName"],
        serialNo: json["serialNo"],
        serviceType: json["serviceType"],
      );

  Map<String, dynamic> toJson() => {
        "isShuffle": isShuffle,
        "isSuspend": isSuspend,
        "language": language,
        "packExpiry": packExpiry,
        "packName": packName,
        "serialNo": serialNo,
        "serviceType": serviceType,
      };
}

class ToneDetail {
  String? toneId;
  String? toneName;
  String? toneUrl;
  String? previewImageUrl;
  String? albumName;
  String? artistName;
  int? price;
  String? createdDate;
  String? isShuffle;
  String? status;
  String? endTime;
  String? startTime;
  String? endDayMonthly;
  String? endTimeMonthly;
  String? startDayMonthly;
  String? startTimeMonthly;
  String? endTimeWeekly;
  String? startTimeWeekly;
  String? weeklyDays;
  String? customiseEndDate;
  String? customiseEndTime;
  String? customiseStartDate;
  String? customiseStartTime;
  String? yearlyEndDay;
  String? yearlyEndMonth;
  String? yearlyEndTime;
  String? yearlyStartDay;
  String? yearlyStartMonth;
  String? yearlyStartTime;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;

  ToneDetail({
    this.toneId,
    this.toneName,
    this.toneUrl,
    this.previewImageUrl,
    this.albumName,
    this.artistName,
    this.price,
    this.createdDate,
    this.isShuffle,
    this.status,
    this.endTime,
    this.startTime,
    this.endDayMonthly,
    this.endTimeMonthly,
    this.startDayMonthly,
    this.startTimeMonthly,
    this.endTimeWeekly,
    this.startTimeWeekly,
    this.weeklyDays,
    this.customiseEndDate,
    this.customiseEndTime,
    this.customiseStartDate,
    this.customiseStartTime,
    this.yearlyEndDay,
    this.yearlyEndMonth,
    this.yearlyEndTime,
    this.yearlyStartDay,
    this.yearlyStartMonth,
    this.yearlyStartTime,
    this.toneIdStreamingUrl,
    this.toneIdpreviewImageUrl,
  });

  factory ToneDetail.fromJson(Map<String, dynamic> json) => ToneDetail(
        toneId: json["toneId"],
        toneName: json["toneName"],
        toneUrl: json["toneUrl"],
        previewImageUrl: json["previewImageUrl"],
        albumName: json["albumName"],
        artistName: json["artistName"],
        price: json["price"],
        createdDate: json["createdDate"],
        isShuffle: json["isShuffle"],
        status: json["status"],
        endTime: json["endTime"],
        startTime: json["startTime"],
        endDayMonthly: json["endDayMonthly"],
        endTimeMonthly: json["endTimeMonthly"],
        startDayMonthly: json["startDayMonthly"],
        startTimeMonthly: json["startTimeMonthly"],
        endTimeWeekly: json["endTimeWeekly"],
        startTimeWeekly: json["startTimeWeekly"],
        weeklyDays: json["weeklyDays"],
        customiseEndDate: json["customiseEndDate"],
        customiseEndTime: json["customiseEndTime"],
        customiseStartDate: json["customiseStartDate"],
        customiseStartTime: json["customiseStartTime"],
        yearlyEndDay: json["yearlyEndDay"],
        yearlyEndMonth: json["yearlyEndMonth"],
        yearlyEndTime: json["yearlyEndTime"],
        yearlyStartDay: json["yearlyStartDay"],
        yearlyStartMonth: json["yearlyStartMonth"],
        yearlyStartTime: json["yearlyStartTime"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "toneUrl": toneUrl,
        "previewImageUrl": previewImageUrl,
        "albumName": albumName,
        "artistName": artistName,
        "price": price,
        "createdDate": createdDate,
        "isShuffle": isShuffle,
        "status": status,
        "endTime": endTime,
        "startTime": startTime,
        "endDayMonthly": endDayMonthly,
        "endTimeMonthly": endTimeMonthly,
        "startDayMonthly": startDayMonthly,
        "startTimeMonthly": startTimeMonthly,
        "endTimeWeekly": endTimeWeekly,
        "startTimeWeekly": startTimeWeekly,
        "weeklyDays": weeklyDays,
        "customiseEndDate": customiseEndDate,
        "customiseEndTime": customiseEndTime,
        "customiseStartDate": customiseStartDate,
        "customiseStartTime": customiseStartTime,
        "yearlyEndDay": yearlyEndDay,
        "yearlyEndMonth": yearlyEndMonth,
        "yearlyEndTime": yearlyEndTime,
        "yearlyStartDay": yearlyStartDay,
        "yearlyStartMonth": yearlyStartMonth,
        "yearlyStartTime": yearlyStartTime,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
      };
}
