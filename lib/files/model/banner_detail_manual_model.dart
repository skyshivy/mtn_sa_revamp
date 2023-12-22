// To parse this JSON data, do
//
//     final bannerDetailManualModel = bannerDetailManualModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

BannerDetailManualModel bannerDetailManualModelFromJson(String str) =>
    BannerDetailManualModel.fromJson(json.decode(str));

String bannerDetailManualModelToJson(BannerDetailManualModel data) =>
    json.encode(data.toJson());

class BannerDetailManualModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  BannerDetailManualModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory BannerDetailManualModel.fromJson(Map<String, dynamic> json) =>
      BannerDetailManualModel(
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
  String? responseDescription;
  List<TuneInfo>? bannerDetailsList;

  ResponseMap({
    this.responseDescription,
    this.bannerDetailsList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        responseDescription: json["responseDescription"],
        bannerDetailsList: json["bannerDetailsList"] == null
            ? []
            : List<TuneInfo>.from(
                json["bannerDetailsList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseDescription": responseDescription,
        "bannerDetailsList": bannerDetailsList == null
            ? []
            : List<dynamic>.from(bannerDetailsList!.map((x) => x.toJson())),
      };
}
/*
class BannerDetailsList {
    String? id;
    String? contentId;
    String? contentName;
    String? path;
    String? previewImage;
    String? album;
    String? artist;
    String? tuneType;
    String? bannerOrder;

    BannerDetailsList({
        this.id,
        this.contentId,
        this.contentName,
        this.path,
        this.previewImage,
        this.album,
        this.artist,
        this.tuneType,
        this.bannerOrder,
    });

    factory BannerDetailsList.fromJson(Map<String, dynamic> json) => BannerDetailsList(
        id: json["id"],
        contentId: json["contentId"],
        contentName: json["contentName"],
        path: json["path"],
        previewImage: json["previewImage"],
        album: json["album"],
        artist: json["artist"],
        tuneType: json["tuneType"],
        bannerOrder: json["bannerOrder"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contentId": contentId,
        "contentName": contentName,
        "path": path,
        "previewImage": previewImage,
        "album": album,
        "artist": artist,
        "tuneType": tuneType,
        "bannerOrder": bannerOrder,
    };
}
*/