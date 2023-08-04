// To parse this JSON data, do
//
//     final artistModel = artistModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

ArtistModel artistModelFromJson(String str) =>
    ArtistModel.fromJson(json.decode(str));

String artistModelToJson(ArtistModel data) => json.encode(data.toJson());

class ArtistModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  ArtistModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
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
  int? totalCount;

  ResponseMap({
    this.searchList,
    this.totalCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        searchList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "searchList": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}
/*
class SearchList {
    String? toneId;
    String? previewImageUrl;
    String? toneUrl;
    String? toneName;
    String? artistName;
    String? albumName;
    int? price;
    int? categoryId;
    String? expiryDate;
    String? toneIdStreamingUrl;
    String? toneIdpreviewImageUrl;

    SearchList({
        this.toneId,
        this.previewImageUrl,
        this.toneUrl,
        this.toneName,
        this.artistName,
        this.albumName,
        this.price,
        this.categoryId,
        this.expiryDate,
        this.toneIdStreamingUrl,
        this.toneIdpreviewImageUrl,
    });

    factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
        toneId: json["toneId"],
        previewImageUrl: json["previewImageUrl"],
        toneUrl: json["toneUrl"],
        toneName: json["toneName"],
        artistName: json["artistName"],
        albumName: json["albumName"],
        price: json["price"],
        categoryId: json["categoryId"],
        expiryDate: json["expiryDate"],
        toneIdStreamingUrl: json["toneIdStreamingUrl"],
        toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "previewImageUrl": previewImageUrl,
        "toneUrl": toneUrl,
        "toneName": toneName,
        "artistName": artistName,
        "albumName": albumName,
        "price": price,
        "categoryId": categoryId,
        "expiryDate": expiryDate,
        "toneIdStreamingUrl": toneIdStreamingUrl,
        "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
    };
}
*/