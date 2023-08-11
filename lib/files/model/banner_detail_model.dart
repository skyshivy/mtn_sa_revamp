// To parse this JSON data, do
//
//     final bannerDetailModel = bannerDetailModelFromJson(jsonString);
import 'dart:convert';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

BannerDetailModel bannerDetailModelFromJson(String str) =>
    BannerDetailModel.fromJson(json.decode(str));

String bannerDetailModelToJson(BannerDetailModel data) =>
    json.encode(data.toJson());

class BannerDetailModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  BannerDetailModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory BannerDetailModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailModel(
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
  List<TuneInfo>? searchList;

  ResponseMap({
    this.searchList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        searchList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "searchList": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
      };
}
