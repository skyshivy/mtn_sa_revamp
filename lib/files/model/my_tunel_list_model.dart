// To parse this JSON data, do
//
//     final myTuneListModel = myTuneListModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

MyTuneListModel myTuneListModelFromJson(String str) =>
    MyTuneListModel.fromJson(json.decode(str));

String myTuneListModelToJson(MyTuneListModel data) =>
    json.encode(data.toJson());

class MyTuneListModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MyTuneListModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MyTuneListModel.fromJson(Map<String, dynamic> json) =>
      MyTuneListModel(
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
  List<ListToneApk1>? listToneApk;

  ResponseMap({
    this.listToneApk,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        listToneApk: json["listToneApk"] == null
            ? []
            : List<ListToneApk1>.from(
                json["listToneApk"]!.map((x) => ListToneApk1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listToneApk": listToneApk == null
            ? []
            : List<dynamic>.from(listToneApk!.map((x) => x.toJson())),
      };
}

class ListToneApk1 {
  List<TuneInfo>? toneDetails;
  String? serviceName;
  int? groupId;

  ListToneApk1({
    this.toneDetails,
    this.serviceName,
    this.groupId,
  });

  factory ListToneApk1.fromJson(Map<String, dynamic> json) => ListToneApk1(
        toneDetails: json["toneDetails"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneDetails"]!.map((x) => TuneInfo.fromJson(x))),
        serviceName: json["serviceName"],
        groupId: json["groupId"],
      );

  Map<String, dynamic> toJson() => {
        "toneDetails": toneDetails == null
            ? []
            : List<dynamic>.from(toneDetails!.map((x) => x.toJson())),
        "serviceName": serviceName,
        "groupId": groupId,
      };
}
/*
class ToneDetail {
  String? toneId;
  String? toneName;
  String? toneUrl;
  String? previewImageUrl;
  String? albumName;
  String? artistName;
  int? price;
  String? createdDate;
  String? status;
  String? isCopy;
  String? isGift;
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
    this.status,
    this.isCopy,
    this.isGift,
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
        status: json["status"],
        isCopy: json["isCopy"],
        isGift: json["isGift"],
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
        "status": status,
        "isCopy": isCopy,
        "isGift": isGift,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
      };
}
*/