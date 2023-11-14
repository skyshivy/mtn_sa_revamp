// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

WishlistModel wishlistModelFromJson(String str) =>
    WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  WishlistModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
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
  String? descriptiion;
  List<TuneInfo>? toneDetailsList;

  ResponseMap({
    this.descriptiion,
    this.toneDetailsList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        descriptiion: json["descriptiion"],
        toneDetailsList: json["toneDetailsList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneDetailsList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "descriptiion": descriptiion,
        "toneDetailsList": toneDetailsList == null
            ? []
            : List<dynamic>.from(toneDetailsList!.map((x) => x.toJson())),
      };
}
