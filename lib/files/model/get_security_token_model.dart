// To parse this JSON data, do
//
//     final getSecurityTokenModel = getSecurityTokenModelFromJson(jsonString);

import 'dart:convert';

GetSecurityTokenModel getSecurityTokenModelFromJson(String str) =>
    GetSecurityTokenModel.fromJson(json.decode(str));

String getSecurityTokenModelToJson(GetSecurityTokenModel data) =>
    json.encode(data.toJson());

class GetSecurityTokenModel {
  GetSecurityTokenModel({
    required this.responseMap,
    required this.respTime,
    required this.statusCode,
  });

  ResponseMap responseMap;
  String respTime;
  String statusCode;

  factory GetSecurityTokenModel.fromJson(Map<String, dynamic> json) =>
      GetSecurityTokenModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap.toJson(),
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  ResponseMap({
    required this.securityCounter,
  });

  String securityCounter;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        securityCounter: json["securityCounter"],
      );

  Map<String, dynamic> toJson() => {
        "securityCounter": securityCounter,
      };
}
