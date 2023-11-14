// To parse this JSON data, do
//
//     final sendGiftModel = sendGiftModelFromJson(jsonString);

import 'dart:convert';

SendGiftModel sendGiftModelFromJson(String str) =>
    SendGiftModel.fromJson(json.decode(str));

String sendGiftModelToJson(SendGiftModel data) => json.encode(data.toJson());

class SendGiftModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SendGiftModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SendGiftModel.fromJson(Map<String, dynamic> json) => SendGiftModel(
        responseMap: json["responseMap"] == null
            ? ResponseMap()
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
  String? responseMessage;

  ResponseMap({
    this.responseMessage,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "responseMessage": responseMessage,
      };
}
