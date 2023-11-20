// To parse this JSON data, do
//
//     final packStatusModel = packStatusModelFromJson(jsonString);

import 'dart:convert';

PackStatusModel packStatusModelFromJson(String str) =>
    PackStatusModel.fromJson(json.decode(str));

String packStatusModelToJson(PackStatusModel data) =>
    json.encode(data.toJson());

class PackStatusModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  PackStatusModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory PackStatusModel.fromJson(Map<String, dynamic> json) =>
      PackStatusModel(
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
  PackStatusDetails? packStatusDetails;

  ResponseMap({
    this.packStatusDetails,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        packStatusDetails: json["packStatusDetails"] == null
            ? null
            : PackStatusDetails.fromJson(json["packStatusDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "packStatusDetails": packStatusDetails?.toJson(),
      };
}

class PackStatusDetails {
  String? activeRrbtStatus;
  String? activeCrbtStatus;
  String? languageId;
  String? packName;
  String? rrbtServiceExpiry;
  String? crbtServiceExpiry;

  PackStatusDetails({
    this.activeRrbtStatus,
    this.activeCrbtStatus,
    this.languageId,
    this.packName,
    this.rrbtServiceExpiry,
    this.crbtServiceExpiry,
  });

  factory PackStatusDetails.fromJson(Map<String, dynamic> json) =>
      PackStatusDetails(
        activeRrbtStatus: json["activeRRBTStatus"],
        activeCrbtStatus: json["activeCRBTStatus"],
        languageId: json["languageId"],
        packName: json["packName"],
        rrbtServiceExpiry: json["rrbtServiceExpiry"] == null
            ? null
            : json["rrbtServiceExpiry"],
        crbtServiceExpiry: json["crbtServiceExpiry"] == null
            ? null
            : json["crbtServiceExpiry"],
      );

  Map<String, dynamic> toJson() => {
        "activeRRBTStatus": activeRrbtStatus,
        "activeCRBTStatus": activeCrbtStatus,
        "languageId": languageId,
        "packName": packName,
        "rrbtServiceExpiry": rrbtServiceExpiry,
        //"${rrbtServiceExpiry!.year.toString().padLeft(4, '0')}-${rrbtServiceExpiry!.month.toString().padLeft(2, '0')}-${rrbtServiceExpiry!.day.toString().padLeft(2, '0')}",
        "crbtServiceExpiry": crbtServiceExpiry,
        //"${crbtServiceExpiry!.year.toString().padLeft(4, '0')}-${crbtServiceExpiry!.month.toString().padLeft(2, '0')}-${crbtServiceExpiry!.day.toString().padLeft(2, '0')}",
      };
}
