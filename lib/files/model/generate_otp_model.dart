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
