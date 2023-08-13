// To parse this JSON data, do
//
//     final regenTokenModel = regenTokenModelFromJson(jsonString);

import 'dart:convert';

RegenTokenModel regenTokenModelFromJson(String str) =>
    RegenTokenModel.fromJson(json.decode(str));

String regenTokenModelToJson(RegenTokenModel data) =>
    json.encode(data.toJson());

class RegenTokenModel {
  RegenTokenModel({
    this.responseMap,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? respTime;
  String? statusCode;

  factory RegenTokenModel.fromJson(Map<String, dynamic> json) =>
      RegenTokenModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  ResponseMap({
    this.expiry,
    this.accessToken,
    this.refreshToken,
  });

  int? expiry;
  String? accessToken;
  String? refreshToken;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        expiry: json["expiry"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "expiry": expiry,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
