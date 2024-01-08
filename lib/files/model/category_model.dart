// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  CategoryModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  List<AppCategory>? categories;

  ResponseMap({
    this.categories,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        categories: json["categories"] == null
            ? []
            : List<AppCategory>.from(
                json["categories"]!.map((x) => AppCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class AppCategory {
  String? categoryId;
  String? categoryName;
  String? menuImagePath;
  String? language;
  RxBool? isSelected = false.obs;

  AppCategory({
    this.categoryId,
    this.categoryName,
    this.menuImagePath,
    this.language,
  });

  factory AppCategory.fromJson(Map<String, dynamic> json) {
    var unescape = HtmlUnescape();

    return AppCategory(
      categoryId: json["categoryId"],
      categoryName: unescape.convert(json["categoryName"] ?? ''),
      menuImagePath: json["menuImagePath"],
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "menuImagePath": menuImagePath,
        "language": language,
      };
}
