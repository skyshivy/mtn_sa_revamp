// To parse this JSON data, do
//
//     final addToWishListModel = addToWishListModelFromJson(jsonString);

import 'dart:convert';

AddToWishListModel addToWishListModelFromJson(String str) =>
    AddToWishListModel.fromJson(json.decode(str));

String addToWishListModelToJson(AddToWishListModel data) =>
    json.encode(data.toJson());

class AddToWishListModel {
  AddToWishListModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory AddToWishListModel.fromJson(Map<String, dynamic> json) =>
      AddToWishListModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
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
  ResponseMap();

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap();

  Map<String, dynamic> toJson() => {};
}
