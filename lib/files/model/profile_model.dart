// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  ResponseMap({
    this.getProfileDetails,
  });

  GetProfileDetails? getProfileDetails;

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        getProfileDetails:
            GetProfileDetails.fromJson(json["getProfileDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "getProfileDetails": getProfileDetails?.toJson(),
      };
}

class GetProfileDetails {
  GetProfileDetails({
    this.userName,
    this.msisdn,
    this.emailId,
    this.categories,
    this.clientTxnId,
    this.respDesc,
  });

  String? userName;
  String? msisdn;
  String? emailId;
  String? categories;
  String? clientTxnId;
  String? respDesc;

  factory GetProfileDetails.fromJson(Map<String, dynamic> json) =>
      GetProfileDetails(
        userName: json["userName"],
        msisdn: json["msisdn"],
        emailId: json["emailId"],
        categories: json["categories"],
        clientTxnId: json["clientTxnId"],
        respDesc: json["respDesc"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "msisdn": msisdn,
        "emailId": emailId,
        "categories": categories,
        "clientTxnId": clientTxnId,
        "respDesc": respDesc,
      };
}
