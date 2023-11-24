// To parse this JSON data, do
//
//     final searchToneidModel = searchToneidModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

SearchToneidModel searchToneidModelFromJson(String str) =>
    SearchToneidModel.fromJson(json.decode(str));

String searchToneidModelToJson(SearchToneidModel data) =>
    json.encode(data.toJson());

class SearchToneidModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SearchToneidModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SearchToneidModel.fromJson(Map<String, dynamic> json) =>
      SearchToneidModel(
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
  List<TuneInfo>? toneList;
  int? songTotalCount;
  int? toneTotalCount;
  List<TuneInfo>? songList;

  ResponseMap({
    this.toneList,
    this.songTotalCount,
    this.toneTotalCount,
    this.songList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
        songTotalCount: json["songTotalCount"],
        toneTotalCount: json["toneTotalCount"],
        songList: json["searchList"] == null
            ? []
            : List<TuneInfo>.from(
                json["searchList"]!.map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
        "songTotalCount": songTotalCount,
        "toneTotalCount": toneTotalCount,
        "searchList": songList == null
            ? []
            : List<dynamic>.from(songList!.map((x) => x.toJson())),
      };
}
/*
class SongListElement {
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

    SongListElement({
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

    factory SongListElement.fromJson(Map<String, dynamic> json) => SongListElement(
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