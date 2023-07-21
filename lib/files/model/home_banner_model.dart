// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

HomeBannerModel homeBannerModelFromJson(String str) =>
    HomeBannerModel.fromJson(json.decode(str));

String homeBannerModelToJson(HomeBannerModel data) =>
    json.encode(data.toJson());

class HomeBannerModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  HomeBannerModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) =>
      HomeBannerModel(
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
  List<Banner>? banners;

  ResponseMap({
    this.banners,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        banners: json["banners"] == null
            ? []
            : List<Banner>.from(
                json["banners"]!.map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
      };
}

class Banner {
  String? language;
  String? bannerPath;
  String? type;
  String? searchKey;
  String? bannerOrder;

  Banner({
    this.language,
    this.bannerPath,
    this.type,
    this.searchKey,
    this.bannerOrder,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        language: json["language"],
        bannerPath: json["bannerPath"],
        type: json["type"],
        searchKey: json["searchKey"],
        bannerOrder: json["bannerOrder"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "bannerPath": bannerPath,
        "type": type,
        "searchKey": searchKey,
        "bannerOrder": bannerOrder,
      };
}
