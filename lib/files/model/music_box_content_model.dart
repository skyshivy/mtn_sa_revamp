// To parse this JSON data, do
//
//     final musicBoxContentModel = musicBoxContentModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

MusicBoxContentModel musicBoxContentModelFromJson(String str) =>
    MusicBoxContentModel.fromJson(json.decode(str));

String musicBoxContentModelToJson(MusicBoxContentModel data) =>
    json.encode(data.toJson());

class MusicBoxContentModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MusicBoxContentModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MusicBoxContentModel.fromJson(Map<String, dynamic> json) =>
      MusicBoxContentModel(
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
/*
class SearchList {
  String? toneId;
  String? toneName;
  String? previewImageUrl;
  String? toneUrl;
  String? artistName;
  int? categoryId;

  SearchList({
    this.toneId,
    this.toneName,
    this.previewImageUrl,
    this.toneUrl,
    this.artistName,
    this.categoryId,
  });

  factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
        toneId: json["toneId"],
        toneName: json["toneName"],
        previewImageUrl: json["previewImageUrl"],
        toneUrl: json["toneUrl"],
        artistName: json["artistName"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "toneId": toneId,
        "toneName": toneName,
        "previewImageUrl": previewImageUrl,
        "toneUrl": toneUrl,
        "artistName": artistName,
        "categoryId": categoryId,
      };
}
*/