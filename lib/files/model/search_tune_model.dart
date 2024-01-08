// To parse this JSON data, do
//
//     final searchTuneModel = searchTuneModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

SearchTuneModel searchTuneModelFromJson(String str) =>
    SearchTuneModel.fromJson(json.decode(str));

String searchTuneModelToJson(SearchTuneModel data) =>
    json.encode(data.toJson());

class SearchTuneModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  SearchTuneModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory SearchTuneModel.fromJson(Map<String, dynamic> json) =>
      SearchTuneModel(
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
  CountList? countList;
  List<TuneInfo>? toneList;
  int? songTotalCount;
  int? toneTotalCount;
  List<TuneInfo>? songList;
  int? albumTotalCount;

  ResponseMap({
    this.countList,
    this.toneList,
    this.songTotalCount,
    this.toneTotalCount,
    this.songList,
    this.albumTotalCount,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        countList: json["countList"] == null
            ? CountList()
            : CountList.fromJson(json["countList"]),
        toneList: json["toneList"] == null
            ? []
            : List<TuneInfo>.from(
                json["toneList"]!.map((x) => TuneInfo.fromJson(x))),
        songTotalCount: json["songTotalCount"],
        toneTotalCount: json["toneTotalCount"],
        songList: json["songList"] == null
            ? []
            : List<TuneInfo>.from(
                json["songList"]!.map((x) => TuneInfo.fromJson(x))),
        albumTotalCount: json["albumTotalCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "countList": countList?.toJson(),
        "toneList": toneList == null
            ? []
            : List<dynamic>.from(toneList!.map((x) => x.toJson())),
        "songTotalCount": songTotalCount,
        "toneTotalCount": toneTotalCount,
        "songList": songList == null
            ? []
            : List<dynamic>.from(songList!.map((x) => x.toJson())),
        "albumTotalCount": albumTotalCount,
      };
}

class CountList {
  List<ArtistDetailList?>? artistDetailList;

  CountList({
    this.artistDetailList,
  });

  factory CountList.fromJson(Map<String, dynamic> json) => CountList(
        artistDetailList: json["artistDetailList"] == null
            ? []
            : List<ArtistDetailList>.from(json["artistDetailList"]!
                .map((x) => ArtistDetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "artistDetailList": artistDetailList == null
            ? []
            : List<dynamic>.from(artistDetailList!.map((x) => x?.toJson())),
      };
}

class ArtistDetailList {
  String? matchedParam;
  String? count;

  ArtistDetailList({
    this.matchedParam,
    this.count,
  });

  factory ArtistDetailList.fromJson(Map<String, dynamic> json) =>
      ArtistDetailList(
        matchedParam: json["matchedParam"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "matchedParam": matchedParam,
        "count": count,
      };
}
