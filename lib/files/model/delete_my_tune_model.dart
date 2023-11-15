// To parse this JSON data, do
//
//     final deleteMyTuneModel = deleteMyTuneModelFromJson(jsonString);

import 'dart:convert';

DeleteMyTuneModel deleteMyTuneModelFromJson(String str) =>
    DeleteMyTuneModel.fromJson(json.decode(str));

String deleteMyTuneModelToJson(DeleteMyTuneModel data) =>
    json.encode(data.toJson());

class DeleteMyTuneModel {
  DeleteMyTuneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory DeleteMyTuneModel.fromJson(Map<String, dynamic> json) =>
      DeleteMyTuneModel(
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
