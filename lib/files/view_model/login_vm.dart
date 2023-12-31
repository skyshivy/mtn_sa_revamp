import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/get_security_token_model.dart';

import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/password_validation_vm.dart';

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

  Future<ConfirmOtpModel?> confirmOtp(String msisdn, String otp) async {
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
    Map<String, dynamic>? stringData = await ServiceCall().post(url, formData);
    //final stringData = await resp.transform(utf8.decoder).join();
    print("Result is ======= $stringData");
    if (stringData != null) {
      ConfirmOtpModel model = ConfirmOtpModel.fromJson(stringData);
      print("Result is ======= $stringData");
      return model;
    } else {
      return null;
    }
    // } else {
    //   return ConfirmOtpModel(
    //       message: someThingWentWrongStr, statusCode: "FL0000");
    // }
  }

  Future<GetSecurityTokenModel?> securityTokenApi() async {
    String ur = getSecurityTokenUrl;
    Map<String, dynamic>? result = await ServiceCall().get(ur);
    if (result != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(result);
      return model;
    }
    return null;
  }

  Future<Map<String, dynamic>?> passwordValidation(
      String securityCounter, String msisdn) async {
    Map<String, dynamic>? map =
        await PasswordValidationVm().validatePassword(msisdn, securityCounter);
    return map;
    // Random random = Random();
    // int randomNumber = random.nextInt(1000000000);
    // String url = passwordValidationUrl;
    // var pass = 'Oem@L#@1';
    // var password = "$pass$securityCounter";
    // print("password is here " + password);
    // String encryptedPassword = Cryptom().text(password);
    // print("encryptedPassword ==========================${encryptedPassword}");

    // var myPost = {
    //   'type': 'ValidateDetails',
    //   'msisdn': msisdn,
    //   'languageId': StoreManager().languageCode,
    //   'clientTxnId': '$randomNumber',
    //   'securityCounter': securityCounter,
    //   'encryptedPassword': encryptedPassword,
    //   'versionCode': '1.2'
    // };
    // var parts = [];
    // myPost.forEach((key, value) {
    //   parts.add('${Uri.encodeQueryComponent(key)}='
    //       '${Uri.encodeQueryComponent(value)}');
    // });
    // var formData = parts.join('&');
    // Map<String, dynamic>? re = await ServiceCall().post(url, formData);
    // return re;
  }
}
