// To parse this JSON data, do
//
//     final advanceSearchModel = advanceSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

AdvanceSearchModel advanceSearchModelFromJson(String str) =>
    AdvanceSearchModel.fromJson(json.decode(str));

String advanceSearchModelToJson(AdvanceSearchModel data) =>
    json.encode(data.toJson());

class AdvanceSearchModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  AdvanceSearchModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory AdvanceSearchModel.fromJson(Map<String, dynamic> json) =>
      AdvanceSearchModel(
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
  List<TuneInfo>? toneList;

  ResponseMap({
    this.toneList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
      };
}
