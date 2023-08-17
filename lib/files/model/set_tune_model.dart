// To parse this JSON data, do
//
//     final setToneModel = setToneModelFromJson(jsonString);

import 'dart:convert';

SetToneModel setToneModelFromJson(String str) =>
    SetToneModel.fromJson(json.decode(str));

String setToneModelToJson(SetToneModel data) => json.encode(data.toJson());

class SetToneModel {
  SetToneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory SetToneModel.fromJson(Map<String, dynamic> json) => SetToneModel(
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
