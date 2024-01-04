// To parse this JSON data, do
//
//     final setStatusTuneModel = setStatusTuneModelFromJson(jsonString);

import 'dart:convert';

SetStatusTuneModel setStatusTuneModelFromJson(String str) =>
    SetStatusTuneModel.fromJson(json.decode(str));

String setStatusTuneModelToJson(SetStatusTuneModel data) =>
    json.encode(data.toJson());

class SetStatusTuneModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SetStatusTuneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SetStatusTuneModel.fromJson(Map<String, dynamic> json) =>
      SetStatusTuneModel(
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
  String? transactionId;

  ResponseMap({
    this.transactionId,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
      };
}
