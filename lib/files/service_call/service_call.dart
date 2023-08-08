import 'dart:convert';
import 'dart:html';

import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';

class ServiceCall {
  final client = HttpClient();

  getSetting(String url) async {
    try {
      var request = await client
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: StoreManager().timeOutDuration));
      HttpClientResponse response1 = await request.close();
      final stringData = await response1.transform(utf8.decoder).join();
      print("Url is $url");
      print("App Setting resp code is ${response1.statusCode}");
      if (response1.statusCode == 200) {
        Map<String, dynamic> valueMap = json.decode(stringData);
        AppSettingModel setting = AppSettingModel.fromJson(valueMap);
        StoreManager().storeAppSettingModel(setting);
        StoreManager().appSetting = setting;
      }
    } catch (error) {
      print("error for url #${url}");
      print("error =   =  ${error}");
    }
  }

  Future<HttpClientResponse> postMsisdnValidation(
      String url, String msisdn, String? formData) async {
    var request = await client
        .postUrl(Uri.parse(url))
        .timeout(Duration(seconds: StoreManager().timeOutDuration));
    request.headers.set('msisdn', msisdn, preserveHeaderCase: true);
    request = await CustomHeader().settingHeader(url, request);
    if (formData != null) {
      request.write(formData);
    }
    HttpClientResponse response = await request.close();
    return response;
    // final stringData = await response.transform(utf8.decoder).join();
    // return stringData;
  }

  Future<String> genOtp(String url, String msisdn) async {
    var request = await client
        .getUrl(Uri.parse(url))
        .timeout(Duration(seconds: StoreManager().timeOutDuration));
    request.headers.set('os', os, preserveHeaderCase: true);
    request.headers
        .set('language', StoreManager().language, preserveHeaderCase: true);
    request.headers.set('deviceId', '0191212', preserveHeaderCase: true);
    request.headers.set('msisdn', msisdn, preserveHeaderCase: true);

    HttpClientResponse response = await request.close();

    final stringData = await response.transform(utf8.decoder).join();
    return stringData;
    print(stringData);
  }

  Future<HttpClientResponse> post(String url, String? formData) async {
    var request = await client
        .postUrl(Uri.parse(url))
        .timeout(Duration(seconds: StoreManager().timeOutDuration));
    request = await CustomHeader().settingHeader(url, request);
    if (formData != null) {
      request.write(formData);
    }
    HttpClientResponse response = await request.close();
    return response;
  }

  Future<Map<String, dynamic>?> get(String url) async {
    try {
      var request = await client
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: StoreManager().timeOutDuration));
      request = await CustomHeader().settingHeader(url, request);
      HttpClientResponse response1 = await request.close();
      final stringData = await response1.transform(utf8.decoder).join();
      print(stringData);
      print("resp code is ${response1.statusCode}");
      if (response1.statusCode == 200) {
        Map<String, dynamic> valueMap = json.decode(stringData);
        return valueMap;
      } else {
        return null;
      }
    } catch (error) {
      print("error for url #${url}");
      print("error =   =  ${error}");
      return null;
    }
  }
}
