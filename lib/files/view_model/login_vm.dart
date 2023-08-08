import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class LoginVm {
  Future<String> subscribeMsisdn(String msisdn) async {
    var url = subscriberValidationUrl;
    var parts = [];
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    var myPost = {
      "language": StoreManager().language,
      "clientTxnId": "$randomNumber",
      "type": "CheckMsisdnSendOTP"
    };
    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    print("\nformed data is \n$formData\n");

    HttpClientResponse response =
        await ServiceCall().postMsisdnValidation(url, msisdn, formData);
    final stringData = await response.transform(utf8.decoder).join();

    return stringData;
  }

  Future<GenerateOtpModel> generateOtp(String msisdn) async {
    var url = generateOtpUrl;
    Map<String, String> headers = {
      'os': 'ios',
      'language': StoreManager().language,
      'deviceId': '0191212',
      'msisdn': msisdn
    };
    final stringData = await ServiceCall().genOtp(url, msisdn);
    print(stringData);

    Map<String, dynamic> valueMap = json.decode(stringData);
    GenerateOtpModel model = GenerateOtpModel.fromJson(valueMap);
    print('===========${valueMap}');
    return model;
  }

  Future<ConfirmOtpModel> confirmOtp(String msisdn, String otp) async {
    var param = {
      "otp": otp,
      "msisdn": msisdn,
      "language": StoreManager().language,
    };

    var parts = [];
    param.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    print("\nformed data is \n$formData\n");

    String url = confirmOtpUrl;
    HttpClientResponse resp = await ServiceCall().post(url, formData);
    final stringData = await resp.transform(utf8.decoder).join();
    Map<String, dynamic> valueMap = json.decode(stringData);
    ConfirmOtpModel model = ConfirmOtpModel.fromJson(valueMap);
    print("Result is ======= $stringData");
    return model;
    // } else {
    //   return ConfirmOtpModel(
    //       message: someThingWentWrongStr, statusCode: "FL0000");
    // }
  }
}
