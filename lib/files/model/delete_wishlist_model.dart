// To parse this JSON data, do
//
//     final deleteWishlistModel = deleteWishlistModelFromJson(jsonString);

import 'dart:convert';

DeleteWishlistModel deleteWishlistModelFromJson(String str) =>
    DeleteWishlistModel.fromJson(json.decode(str));

String deleteWishlistModelToJson(DeleteWishlistModel data) =>
    json.encode(data.toJson());

class DeleteWishlistModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  DeleteWishlistModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory DeleteWishlistModel.fromJson(Map<String, dynamic> json) =>
      DeleteWishlistModel(
        responseMap: json["responseMap"] == null
            ? ResponseMap()
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
  String? descriptiion;
  List<DeletionStatusList>? deletionStatusList;
  String? msisdn;

  ResponseMap({
    this.descriptiion,
    this.deletionStatusList,
    this.msisdn,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        descriptiion: json["descriptiion"],
        deletionStatusList: json["deletionStatusList"] == null
            ? []
            : List<DeletionStatusList>.from(json["deletionStatusList"]!
                .map((x) => DeletionStatusList.fromJson(x))),
        msisdn: json["msisdn"],
      );

  Map<String, dynamic> toJson() => {
        "descriptiion": descriptiion,
        "deletionStatusList": deletionStatusList == null
            ? []
            : List<dynamic>.from(deletionStatusList!.map((x) => x.toJson())),
        "msisdn": msisdn,
      };
}

class DeletionStatusList {
  String? id;
  String? status;

  DeletionStatusList({
    this.id,
    this.status,
  });

  factory DeletionStatusList.fromJson(Map<String, dynamic> json) =>
      DeletionStatusList(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
