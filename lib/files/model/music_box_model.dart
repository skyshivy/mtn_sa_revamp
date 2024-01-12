// To parse this JSON data, do
//
//     final musicBoxModel = musicBoxModelFromJson(jsonString);

import 'dart:convert';

MusicBoxModel musicBoxModelFromJson(String str) =>
    MusicBoxModel.fromJson(json.decode(str));

String musicBoxModelToJson(MusicBoxModel data) => json.encode(data.toJson());

class MusicBoxModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  MusicBoxModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory MusicBoxModel.fromJson(Map<String, dynamic> json) => MusicBoxModel(
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
  List<MusicBoxSearchList>? musicBoxSearchList;

  ResponseMap({
    this.musicBoxSearchList,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        musicBoxSearchList: json["musicBoxSearchList"] == null
            ? []
            : List<MusicBoxSearchList>.from(json["musicBoxSearchList"]!
                .map((x) => MusicBoxSearchList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "musicBoxSearchList": musicBoxSearchList == null
            ? []
            : List<dynamic>.from(musicBoxSearchList!.map((x) => x.toJson())),
      };
}

class MusicBoxSearchList {
  String? channelName;
  int? price;
  String? validity;
  String? description;
  String? toneCode;
  String? parentToneCode;
  String? childToneCode;
  String? entityId;
  String? type;
  String? previewImageUrl;
  String? previewContent;
  String? artistName;
  int? categoryId;

  MusicBoxSearchList({
    this.channelName,
    this.price,
    this.validity,
    this.description,
    this.toneCode,
    this.parentToneCode,
    this.childToneCode,
    this.entityId,
    this.type,
    this.previewImageUrl,
    this.previewContent,
    this.artistName,
    this.categoryId,
  });

  factory MusicBoxSearchList.fromJson(Map<String, dynamic> json) =>
      MusicBoxSearchList(
        channelName: json["channelName"],
        price: json["price"],
        validity: json["validity"],
        description: json["description"],
        toneCode: json["toneCode"],
        parentToneCode: json["parentToneCode"],
        childToneCode: json["childToneCode"],
        entityId: json["entityId"],
        type: json["type"],
        previewImageUrl: json["previewImageUrl"],
        previewContent: json["previewContent"],
        artistName: json["artistName"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "channelName": channelName,
        "price": price,
        "validity": validity,
        "description": description,
        "toneCode": toneCode,
        "parentToneCode": parentToneCode,
        "childToneCode": childToneCode,
        "entityId": entityId,
        "type": type,
        "previewImageUrl": previewImageUrl,
        "previewContent": previewContent,
        "artistName": artistName,
        "categoryId": categoryId,
      };
}
