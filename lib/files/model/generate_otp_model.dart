// To parse this JSON data, do
//
//     final generateOtpModel = generateOtpModelFromJson(jsonString);

import 'dart:convert';

GenerateOtpModel generateOtpModelFromJson(String str) =>
    GenerateOtpModel.fromJson(json.decode(str));

String generateOtpModelToJson(GenerateOtpModel data) =>
    json.encode(data.toJson());

class GenerateOtpModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  GenerateOtpModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) =>
      GenerateOtpModel(
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
  String? respDesc;
  String? userData;
  String? clientTxnId;
  String? srvType;
  String? respCode;
  String? txnId;

  ResponseMap({
    this.respDesc,
    this.userData,
    this.clientTxnId,
    this.srvType,
    this.respCode,
    this.txnId,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        respDesc: json["respDesc"],
        userData: json["userData"],
        clientTxnId: json["clientTxnId"],
        srvType: json["srvType"],
        respCode: json["respCode"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "respDesc": respDesc,
        "userData": userData,
        "clientTxnId": clientTxnId,
        "srvType": srvType,
        "respCode": respCode,
        "txnId": txnId,
      };
}

/*
// To parse this JSON data, do
//
//     final generateOtpModel = generateOtpModelFromJson(jsonString);

import 'dart:convert';

GenerateOtpModel generateOtpModelFromJson(String str) =>
    GenerateOtpModel.fromJson(json.decode(str));

String generateOtpModelToJson(GenerateOtpModel data) =>
    json.encode(data.toJson());

class GenerateOtpModel {
  GenerateOtpModel({
    required this.responseMap,
    required this.message,
    required this.respTime,
    required this.statusCode,
  });

  ResponseMap responseMap;
  String message;
  String respTime;
  String statusCode;

  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) =>
      GenerateOtpModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap.toJson(),
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  ResponseMap({
    required this.respDesc,
    required this.clientTxnId,
    required this.srvType,
    required this.respCode,
    required this.txnId,
  });

  String respDesc;
  String clientTxnId;
  String srvType;
  String respCode;
  String txnId;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        respDesc: json["respDesc"],
        clientTxnId: json["clientTxnId"],
        srvType: json["srvType"],
        respCode: json["respCode"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "respDesc": respDesc,
        "clientTxnId": clientTxnId,
        "srvType": srvType,
        "respCode": respCode,
        "txnId": txnId,
      };
}
*/