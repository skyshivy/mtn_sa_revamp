// To parse this JSON data, do
//
//     final newUserRegistrationModel = newUserRegistrationModelFromJson(jsonString);

import 'dart:convert';

NewUserRegistrationModel newUserRegistrationModelFromJson(String str) =>
    NewUserRegistrationModel.fromJson(json.decode(str));

String newUserRegistrationModelToJson(NewUserRegistrationModel data) =>
    json.encode(data.toJson());

class NewUserRegistrationModel {
  NewUserRegistrationModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory NewUserRegistrationModel.fromJson(Map<String, dynamic> json) =>
      NewUserRegistrationModel(
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
    this.msisdn,
    this.secToc,
    this.txnId,
  });

  String? respDesc;
  String? clientTxnId;
  String? srvType;
  String? msisdn;
  String? secToc;
  String? txnId;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        respDesc: json["respDesc"],
        clientTxnId: json["clientTxnId"],
        srvType: json["srvType"],
        msisdn: json["msisdn"],
        secToc: json["secToc"],
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "respDesc": respDesc,
        "clientTxnId": clientTxnId,
        "srvType": srvType,
        "msisdn": msisdn,
        "secToc": secToc,
        "txnId": txnId,
      };
}
