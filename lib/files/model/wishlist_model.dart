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

/*
class ToneDetailsList {
  String? id;
  String? contentId;
  String? contentName;
  String? path;
  String? previewImageUrl;
  String? album;
  String? artist;
  String? msisdn;
  String? price;
  DateTime? createdDate;
  String? wishListType;
  String? likeCount;

  ToneDetailsList({
    this.id,
    this.contentId,
    this.contentName,
    this.path,
    this.previewImageUrl,
    this.album,
    this.artist,
    this.msisdn,
    this.price,
    this.createdDate,
    this.wishListType,
    this.likeCount,
  });

  factory ToneDetailsList.fromJson(Map<String, dynamic> json) =>
      ToneDetailsList(
        id: json["id"],
        contentId: json["contentId"],
        contentName: json["contentName"],
        path: json["path"],
        previewImageUrl: json["previewImageUrl"],
        album: json["album"],
        artist: json["artist"],
        msisdn: json["msisdn"],
        price: json["price"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        wishListType: json["wishListType"],
        likeCount: json["likeCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contentId": contentId,
        "contentName": contentName,
        "path": path,
        "previewImageUrl": previewImageUrl,
        "album": album,
        "artist": artist,
        "msisdn": msisdn,
        "price": price,
        "createdDate": createdDate?.toIso8601String(),
        "wishListType": wishListType,
        "likeCount": likeCount,
      };
}
*/
