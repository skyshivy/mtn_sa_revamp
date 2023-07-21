// To parse this JSON data, do
//
//     final homeRecomModel = homeRecomModelFromJson(jsonString);

import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';

HomeRecomModel homeRecomModelFromJson(String str) =>
    HomeRecomModel.fromJson(json.decode(str));

String homeRecomModelToJson(HomeRecomModel data) => json.encode(data.toJson());

class HomeRecomModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  HomeRecomModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory HomeRecomModel.fromJson(Map<String, dynamic> json) => HomeRecomModel(
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
  List<TuneInfo>? recommendationSongsList;

  ResponseMap({
    this.responseDescription,
    this.recommendationSongsList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        responseDescription: json["responseDescription"],
        recommendationSongsList: json["recommendationSongsList"] == null
            ? []
            : List<TuneInfo>.from(json["recommendationSongsList"]!
                .map((x) => TuneInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseDescription": responseDescription,
        "recommendationSongsList": recommendationSongsList == null
            ? []
            : List<TuneInfo>.from(
                recommendationSongsList!.map((x) => x.toJson())),
      };
}

// class RecommendationSongsList {
//     String? categoryId;
//     String? toneId;
//     String? toneName;
//     String? albumName;
//     String? artistName;
//     String? toneUrl;
//     String? previewImageUrl;
//     String? downloadCount;
//     String? likeCount;
//     String? toneIdStreamingUrl;
//     String? toneIdpreviewImageUrl;

//     RecommendationSongsList({
//         this.categoryId,
//         this.toneId,
//         this.toneName,
//         this.albumName,
//         this.artistName,
//         this.toneUrl,
//         this.previewImageUrl,
//         this.downloadCount,
//         this.likeCount,
//         this.toneIdStreamingUrl,
//         this.toneIdpreviewImageUrl,
//     });

//     factory RecommendationSongsList.fromJson(Map<String, dynamic> json) => RecommendationSongsList(
//         categoryId: json["categoryId"],
//         toneId: json["toneId"],
//         toneName: json["toneName"],
//         albumName: json["albumName"],
//         artistName: json["artistName"],
//         toneUrl: json["toneUrl"],
//         previewImageUrl: json["previewImageUrl"],
//         downloadCount: json["downloadCount"],
//         likeCount: json["likeCount"],
//         toneIdStreamingUrl: json["toneIdStreamingUrl"],
//         toneIdpreviewImageUrl: json["toneIdpreviewImageUrl"],
//     );

//     Map<String, dynamic> toJson() => {
//         "categoryId": categoryId,
//         "toneId": toneId,
//         "toneName": toneName,
//         "albumName": albumName,
//         "artistName": artistName,
//         "toneUrl": toneUrl,
//         "previewImageUrl": previewImageUrl,
//         "downloadCount": downloadCount,
//         "likeCount": likeCount,
//         "toneIdStreamingUrl": toneIdStreamingUrl,
//         "toneIdpreviewImageUrl": toneIdpreviewImageUrl,
//     };
// }
