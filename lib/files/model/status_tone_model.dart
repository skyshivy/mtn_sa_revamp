// To parse this JSON data, do
//
//     final statusToneModel = statusToneModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

StatusToneModel statusToneModelFromJson(String str) =>
    StatusToneModel.fromJson(json.decode(str));

String statusToneModelToJson(StatusToneModel data) =>
    json.encode(data.toJson());

class StatusToneModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  StatusToneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory StatusToneModel.fromJson(Map<String, dynamic> json) =>
      StatusToneModel(
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
    String? likeCount;

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
        this.likeCount,
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
        likeCount: json["likeCount"],
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
        "likeCount": likeCount,
    };
}
*/