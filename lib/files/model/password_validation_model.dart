// To parse this JSON data, do
//
//     final passwordValidationModel = passwordValidationModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
// To parse this JSON data, do
//
//     final passwordValidationModel = passwordValidationModelFromJson(jsonString);

import 'dart:convert';

PasswordValidationModel passwordValidationModelFromJson(String str) =>
    PasswordValidationModel.fromJson(json.decode(str));

String passwordValidationModelToJson(PasswordValidationModel data) =>
    json.encode(data.toJson());

class PasswordValidationModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  PasswordValidationModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory PasswordValidationModel.fromJson(Map<String, dynamic> json) =>
      PasswordValidationModel(
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
  String? srvType;
  String? userIdEnc;
  String? userName;
  String? accessToken;
  String? userId;
  String? deviceId;
  String? clientTxnId;
  int? expiry;
  String? msisdn;
  String? txnId;
  String? refreshToken;

  ResponseMap({
    this.respDesc,
    this.srvType,
    this.userIdEnc,
    this.userName,
    this.accessToken,
    this.userId,
    this.deviceId,
    this.clientTxnId,
    this.expiry,
    this.msisdn,
    this.txnId,
    this.refreshToken,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        respDesc: json["respDesc"],
        srvType: json["srvType"],
        userIdEnc: json["userIdEnc"],
        userName: json["userName"],
        accessToken: json["accessToken"],
        userId: json["userId"],
        deviceId: json["deviceId"],
        clientTxnId: json["clientTxnId"],
        expiry: json["expiry"],
        msisdn: json["msisdn"],
        txnId: json["txnId"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "respDesc": respDesc,
        "srvType": srvType,
        "userIdEnc": userIdEnc,
        "userName": userName,
        "accessToken": accessToken,
        "userId": userId,
        "deviceId": deviceId,
        "clientTxnId": clientTxnId,
        "expiry": expiry,
        "msisdn": msisdn,
        "txnId": txnId,
        "refreshToken": refreshToken,
      };
}

/*
PasswordValidationModel passwordValidationModelFromJson(String str) =>
    PasswordValidationModel.fromJson(json.decode(str));

String passwordValidationModelToJson(PasswordValidationModel data) =>
    json.encode(data.toJson());

class PasswordValidationModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  PasswordValidationModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory PasswordValidationModel.fromJson(Map<String, dynamic> json) =>
      PasswordValidationModel(
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
  //Settings? settings;
  String? respDesc;
  String? srvType;
  String? userIdEnc;
  String? userName;
  String? accessToken;
  String? userId;
  String? deviceId;
  String? clientTxnId;
  String? expiry;
  String? msisdn;
  String? txnId;
  String? refreshToken;

  ResponseMap({
    //this.settings,
    this.respDesc,
    this.srvType,
    this.userIdEnc,
    this.userName,
    this.accessToken,
    this.userId,
    this.deviceId,
    this.clientTxnId,
    this.expiry,
    this.msisdn,
    this.txnId,
    this.refreshToken,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        // settings: json["settings"] == null
        //     ? null
        //     : Settings.fromJson(json["settings"]),
        respDesc: json["respDesc"],
        srvType: json["srvType"],
        userIdEnc: json["userIdEnc"],
        userName: json["userName"],
        accessToken: json["accessToken"],
        userId: json["userId"],
        deviceId: json["deviceId"],
        clientTxnId: json["clientTxnId"],
        expiry: "${json["expiry"]}",
        msisdn: json["msisdn"],
        txnId: json["txnId"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        //"settings": settings?.toJson(),
        "respDesc": respDesc,
        "srvType": srvType,
        "userIdEnc": userIdEnc,
        "userName": userName,
        "accessToken": accessToken,
        "userId": userId,
        "deviceId": deviceId,
        "clientTxnId": clientTxnId,
        "expiry": expiry,
        "msisdn": msisdn,
        "txnId": txnId,
        "refreshToken": refreshToken,
      };
}
*/