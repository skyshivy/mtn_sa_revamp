// To parse this JSON data, do
//
//     final buyTuneModel = buyTuneModelFromJson(jsonString);

import 'dart:convert';

BuyTuneModel buyTuneModelFromJson(String str) =>
    BuyTuneModel.fromJson(json.decode(str));

String buyTuneModelToJson(BuyTuneModel data) => json.encode(data.toJson());

class BuyTuneModel {
  BuyTuneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory BuyTuneModel.fromJson(Map<String, dynamic> json) => BuyTuneModel(
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
  ResponseMap({
    this.responseMessage,
  });

  String? responseMessage;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "responseMessage": responseMessage,
      };
}
