// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    this.responseMap,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? respTime;
  String? statusCode;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        responseMap: ResponseMap.fromJson(json["responseMap"]),
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  ResponseMap({
    this.transactionDetailsList,
  });

  List<TransactionDetailsList>? transactionDetailsList;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        transactionDetailsList: json["transactionDetailsList"] != null
            ? List<TransactionDetailsList>.from(json["transactionDetailsList"]
                .map((x) => TransactionDetailsList.fromJson(x)))
            : <TransactionDetailsList>[],
      );

  Map<String, dynamic> toJson() => {
        "transactionDetailsList":
            List<dynamic>.from(transactionDetailsList!.map((x) => x.toJson())),
      };
}

class TransactionDetailsList {
  TransactionDetailsList({
    this.subscriptionDate,
    this.aParty,
    this.bParty,
    this.callCharge,
    this.nextBillingDate,
    this.channel,
    this.toneType,
    this.transactionType,
    this.englishToneName,
  });

  DateTime? subscriptionDate;
  String? aParty;
  String? bParty;
  String? callCharge;
  DateTime? nextBillingDate;
  String? channel;
  String? toneType;
  String? transactionType;
  String? englishToneName;

  factory TransactionDetailsList.fromJson(Map<String, dynamic> json) =>
      TransactionDetailsList(
        subscriptionDate: DateTime.parse(json["subscriptionDate"]),
        aParty: json["aParty"],
        bParty: json["bParty"],
        callCharge: json["callCharge"],
        nextBillingDate: DateTime.parse(json["nextBillingDate"]),
        channel: json["channel"],
        toneType: json["toneType"],
        transactionType: json["transactionType"],
        englishToneName: json["englishToneName"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptionDate": subscriptionDate?.toIso8601String(),
        "aParty": aParty,
        "bParty": bParty,
        "callCharge": callCharge,
        "nextBillingDate": nextBillingDate?.toIso8601String(),
        "channel": channel,
        "toneType": toneType,
        "transactionType": transactionType,
        "englishToneName": englishToneName,
      };
}
/*
enum BParty { N_A, LOCAL_TONES }

final bPartyValues =
    EnumValues({"Local_Tones": BParty.LOCAL_TONES, "N/A": BParty.N_A});

enum Channel { SMS, OBD }

final channelValues = EnumValues({"OBD": Channel.OBD, "SMS": Channel.SMS});

enum TransactionType { ACTIVATED, DEACTIVATED, DAILY_PACK_RENEWED }

final transactionTypeValues = EnumValues({
  "Activated": TransactionType.ACTIVATED,
  "Daily Pack Renewed": TransactionType.DAILY_PACK_RENEWED,
  "Deactivated": TransactionType.DEACTIVATED
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
  
}
*/
