import 'dart:convert';

import 'package:mtn_sa_revamp/files/model/confirm_otp_existing_model.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class ConfirmOtpVM {
  Future<ConfirmOtpModel> confirm(String msisdn, String otp) async {
    var params = {
      "otp": otp,
      "msisdn": msisdn,
      "language": StoreManager().language,
    };
    String url = confirmOtpUrl;
    var parts = [];
    params.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    // await Future.delayed(Duration(seconds: 3));
    // ConfirmOtpModel model = ConfirmOtpModel.fromJson(json.decode(_json));
    // print("Login data a== $model");
    // return model;
    Map<String, dynamic>? map =
        await ServiceCall().post(url, formData); //.post(url, formData);
    if (map != null) {
      ConfirmOtpModel model = ConfirmOtpModel.fromJson(map);
      return model;
    } else {
      ConfirmOtpModel model = ConfirmOtpModel(message: "Errror");
      return model;
    }
  }
}

String _json =
    """{"responseMap":{"expiry":600000,"accessToken":"074bc1d3-f0d7-42f6-a7c6-157946e3b9af","deviceId":"7b9f666f-7b41-4871-9087-17ceec311a77","refreshToken":"4759b88c-9e93-412e-93a7-526abb1398f8"},"message":"Success","respTime":"May 27, 2024 10:49:58 PM","statusCode":"SC0000"}""";
