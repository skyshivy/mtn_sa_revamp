// To parse this JSON data, do
//
//     final packStatusModel = packStatusModelFromJson(jsonString);

import 'dart:convert';

PackStatusModel packStatusModelFromJson(String str) =>
    PackStatusModel.fromJson(json.decode(str));

String packStatusModelToJson(PackStatusModel data) =>
    json.encode(data.toJson());

class PackStatusModel {
  PackStatusModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory PackStatusModel.fromJson(Map<String, dynamic> json) =>
      PackStatusModel(
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
    this.packStatusDetails,
  });

  PackStatusDetails? packStatusDetails;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        packStatusDetails:
            PackStatusDetails.fromJson(json["packStatusDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "packStatusDetails": packStatusDetails?.toJson(),
      };
}

class PackStatusDetails {
  PackStatusDetails({
    this.languageId,
    this.packName,
    this.activeRRBTStatus,
    this.activeCRBTStatus,
  });

  String? languageId;
  String? packName;
  String? activeRRBTStatus;
  String? activeCRBTStatus;

  factory PackStatusDetails.fromJson(Map<String, dynamic> json) =>
      PackStatusDetails(
        languageId: json["languageId"],
        packName: json["packName"],
        activeRRBTStatus: json["activeRRBTStatus"],
        activeCRBTStatus: json["activeCRBTStatus"],
      );

  Map<String, dynamic> toJson() => {
        "languageId": languageId,
        "packName": packName,
        "activeRRBTStatus": activeRRBTStatus,
        "activeCRBTStatus": activeCRBTStatus,
      };
}
