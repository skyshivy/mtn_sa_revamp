// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.faqList,
  });

  List<FaqList>? faqList;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        faqList:
            List<FaqList>.from(json["faqList"].map((x) => FaqList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "faqList": List<dynamic>.from(faqList!.map((x) => x.toJson())),
      };
}

class FaqList {
  FaqList({
    this.question,
    this.answer,
  });

  String? question;
  List<Answer>? answer;
  RxBool? isOpen = false.obs;

  factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
        question: json["question"],
        answer: json["answer"] != null
            ? List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x)))
            : <Answer>[],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": List<dynamic>.from(answer!.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.header,
    this.dataList,
  });

  String? header;
  List<DataList>? dataList;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        header: json["header"],
        dataList: json["dataList"] != null
            ? List<DataList>.from(
                json["dataList"].map((x) => DataList.fromJson(x)))
            : <DataList>[],
      );

  Map<String, dynamic> toJson() => {
        "header": header,
        "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class DataList {
  DataList({
    this.data,
  });

  List<Datum>? data;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : <Datum>[],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.text,
    this.style,
  });

  String? text;
  Style? style;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        text: json["text"],
        style: Style.fromJson(json["style"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "style": style?.toJson(),
      };
}

class Style {
  Style({
    this.fontStyle,
    this.fontWeight,
    this.textDecoration,
  });

  FontStyle? fontStyle;
  int? fontWeight;
  TextDecoration? textDecoration;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        fontStyle: fontStyleValues.map[json["fontStyle"]],
        fontWeight: json["fontWeight"],
        textDecoration: textDecorationValues.map[json["textDecoration"]],
      );

  Map<String, dynamic> toJson() => {
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "textDecoration": textDecorationValues.reverse[textDecoration],
      };
}

enum FontStyle { NORMAL }

final fontStyleValues = EnumValues({"normal": FontStyle.NORMAL});

enum TextDecoration { NONE }

final textDecorationValues = EnumValues({"none": TextDecoration.NONE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}


/*
FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.faqList,
  });

  List<FaqList>? faqList;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        faqList: json["faqList"] != null
            ? List<FaqList>.from(
                json["faqList"].map((x) => FaqList.fromJson(x)))
            : <FaqList>[],
      );

  Map<String, dynamic> toJson() => {
        "faqList": List<dynamic>.from(faqList!.map((x) => x.toJson())),
      };
}

// factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
//         transactionDetailsList: json["transactionDetailsList"] != null
//             ? List<TransactionDetailsList>.from(json["transactionDetailsList"]
//                 .map((x) => TransactionDetailsList.fromJson(x)))
//             : <TransactionDetailsList>[],
//       );

class FaqList {
  FaqList({
    this.question,
    this.answer,
  });

  String? question;
  List<Answer>? answer;
  bool? isOpen = false;

  factory FaqList.fromJson(Map<String, dynamic> json) => FaqList(
        question: json["question"],
        answer: json["answer"] != null
            ? List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x)))
            : <Answer>[],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": List<dynamic>.from(answer!.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.header,
    this.dataList,
  });

  String? header;
  List<DataList>? dataList;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        header: json["header"],
        dataList: json["dataList"] != null
            ? List<DataList>.from(
                json["dataList"].map((x) => DataList.fromJson(x)))
            : <DataList>[],
      );

  Map<String, dynamic> toJson() => {
        "header": header,
        "dataList": List<dynamic>.from(dataList!.map((x) => x.toJson())),
      };
}

class DataList {
  DataList({
    this.data,
  });

  List<Datum>? data;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        data: json["data"]
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : <Datum>[],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.text,
    this.style,
  });

  String? text;
  Style? style;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        text: json["text"],
        style: Style.fromJson(json["style"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "style": style?.toJson(),
      };
}

class Style {
  Style({
    this.fontStyle,
    this.fontWeight,
    this.textDecoration,
  });

  FontStyle? fontStyle;
  int? fontWeight;
  TextDecoration? textDecoration;

  factory Style.fromJson(Map<String, dynamic> json) => Style(
        fontStyle: fontStyleValues.map?[json["fontStyle"]],
        fontWeight: json["fontWeight"],
        textDecoration: textDecorationValues.map?[json["textDecoration"]],
      );

  Map<String, dynamic> toJson() => {
        "fontStyle": fontStyleValues.reverse[fontStyle],
        "fontWeight": fontWeight,
        "textDecoration": textDecorationValues.reverse[textDecoration],
      };
}

enum FontStyle { NORMAL }

final fontStyleValues = EnumValues({"normal": FontStyle.NORMAL});

enum TextDecoration { NONE }

final textDecorationValues = EnumValues({"none": TextDecoration.NONE});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
*/