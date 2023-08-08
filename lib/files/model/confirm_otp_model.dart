// To parse this JSON data, do
//
//     final confirmOtpModel = confirmOtpModelFromJson(jsonString);

import 'dart:convert';

ConfirmOtpModel confirmOtpModelFromJson(String str) =>
    ConfirmOtpModel.fromJson(json.decode(str));

String confirmOtpModelToJson(ConfirmOtpModel data) =>
    json.encode(data.toJson());

class ConfirmOtpModel {
  ConfirmOtpModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory ConfirmOtpModel.fromJson(Map<String, dynamic> json) =>
      ConfirmOtpModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
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
