// To parse this JSON data, do
//
//     final newUserCheckOtpModel = newUserCheckOtpModelFromJson(jsonString);

import 'dart:convert';

NewUserCheckOtpModel newUserCheckOtpModelFromJson(String str) =>
    NewUserCheckOtpModel.fromJson(json.decode(str));

String newUserCheckOtpModelToJson(NewUserCheckOtpModel data) =>
    json.encode(data.toJson());

class NewUserCheckOtpModel {
  NewUserCheckOtpModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory NewUserCheckOtpModel.fromJson(Map<String, dynamic> json) =>
      NewUserCheckOtpModel(
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
    this.respDesc,
    this.clientTxnId,
    this.srvType,
    this.userIdEnc,
    this.msisdn,
    this.userName,
    this.userId,
    this.txnId,
  });

  String? respDesc;
  String? clientTxnId;
  String? srvType;
  String? userIdEnc;
  String? msisdn;
  String? userName;
  String? userId;
  String? txnId;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        respDesc: json["respDesc"],
        clientTxnId: json["clientTxnId"],
        srvType: json["srvType"],
        userIdEnc: json["userIdEnc"],
        msisdn: json["msisdn"],
        userName: json["userName"],
        userId: json["userId"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "respDesc": respDesc,
        "clientTxnId": clientTxnId,
        "srvType": srvType,
        "userIdEnc": userIdEnc,
        "msisdn": msisdn,
        "userName": userName,
        "userId": userId,
        "txnId": txnId,
      };
}
