// To parse this JSON data, do
//
//     final confirmOtpExistingModel = confirmOtpExistingModelFromJson(jsonString);

import 'dart:convert';

ConfirmOtpExistingModel confirmOtpExistingModelFromJson(String str) =>
    ConfirmOtpExistingModel.fromJson(json.decode(str));

String confirmOtpExistingModelToJson(ConfirmOtpExistingModel data) =>
    json.encode(data.toJson());

class ConfirmOtpExistingModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  ConfirmOtpExistingModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory ConfirmOtpExistingModel.fromJson(Map<String, dynamic> json) =>
      ConfirmOtpExistingModel(
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
