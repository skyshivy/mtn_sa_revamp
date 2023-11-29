// To parse this JSON data, do
//
//     final suspendResumeModel = suspendResumeModelFromJson(jsonString);

import 'dart:convert';

SuspendResumeModel suspendResumeModelFromJson(String str) =>
    SuspendResumeModel.fromJson(json.decode(str));

String suspendResumeModelToJson(SuspendResumeModel data) =>
    json.encode(data.toJson());

class SuspendResumeModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SuspendResumeModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SuspendResumeModel.fromJson(Map<String, dynamic> json) =>
      SuspendResumeModel(
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
  ResponseMap();

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap();

  Map<String, dynamic> toJson() => {};
}
