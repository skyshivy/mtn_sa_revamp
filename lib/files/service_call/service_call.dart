import 'dart:convert';
import 'dart:html';

import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/regenerate_model.dart';
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
      print("error for url $url");
      print("error =   =  $error");
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
  }

  Future<Map<String, dynamic>?> post(String url, String? formData) async {
    var request = await client
        .postUrl(Uri.parse(url))
        .timeout(Duration(seconds: StoreManager().timeOutDuration));
    request = await CustomHeader().settingHeader(url, request);
    if (formData != null) {
      request.write(formData);
    }
    HttpClientResponse response = await request.close();
    String stringData = '';
    stringData = await response.transform(utf8.decoder).join();
    print(stringData);
    print("resp code is ${response.statusCode}");
    if (response.statusCode == 498) {
      await ServiceCall().regenarateTokenFromOtherClass();

      var request = await client
          .postUrl(Uri.parse(url))
          .timeout(Duration(seconds: StoreManager().timeOutDuration));
      request = await CustomHeader().settingHeader(url, request);
      if (formData != null) {
        request.write(formData);
      }
      HttpClientResponse response = await request.close();
      stringData = await response.transform(utf8.decoder).join();
    }
    Map<String, dynamic> valueMap = json.decode(stringData);
    return valueMap;
    // } else {
    //   return null;
    // }
  }

  Future<Map<String, dynamic>?> get(String url) async {
    try {
      var request = await client
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: StoreManager().timeOutDuration));
      request = await CustomHeader().settingHeader(url, request);
      String stringData = '';
      HttpClientResponse response1 = await request.close();

      stringData = await response1.transform(utf8.decoder).join();
      print(stringData);
      print("resp code is ${response1.statusCode}");
      if (response1.statusCode == 200) {
        Map<String, dynamic> valueMap = json.decode(stringData);
        return valueMap;
      } else if (response1.statusCode == 498) {
        await ServiceCall().regenarateTokenFromOtherClass();
        var request = await client
            .getUrl(Uri.parse(url))
            .timeout(Duration(seconds: StoreManager().timeOutDuration));
        request = await CustomHeader().settingHeader(url, request);
        String stringData = '';
        HttpClientResponse response1 = await request.close();

        stringData = await response1.transform(utf8.decoder).join();
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

  Future<void> regenarateTokenFromOtherClass() async {
    Map<String, dynamic> res = await reGeneratToken();
    RegenTokenModel model = RegenTokenModel.fromJson(res);
    if (model.statusCode == 'SC0000') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", model.responseMap?.accessToken ?? '');
      prefs.setString("refreshToken", model.responseMap?.refreshToken ?? '');
      await Future.delayed(const Duration(milliseconds: 300));
    } else {
      AppController appCont = Get.find();
      appCont.isLoggedIn.value = false;
      StoreManager().logout();
      //html.window.location.reload();
    }
    print("======Regene token ====== ${model.statusCode}");
    return;
  }

  reGeneratToken() async {
    String refreshToken = StoreManager().refreshToken;
    String accessToken = StoreManager().accessToken;

    String url = regenTokenUrl;
    print("3url used currently is $url");

    var parts = [];
    var body = {'refreshToken': refreshToken};
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    print("\nformed data is \n$formData\n");
    print("line 41");

    var request = await client.postUrl(Uri.parse(url));

    print("line 45");

    request = await CustomHeader().settingHeader(url, request);
    request.write(formData);
    Map<String, dynamic>? result = await httpServiceCall(request);

    return result;
  }

  Future<Map<String, dynamic>?> httpServiceCall(
      HttpClientRequest request) async {
    try {
      HttpClientResponse response = await request.close();

      if (response.statusCode == 498 || response.statusCode == 500) {
        print("Logut in case of regen");
      }
      final stringData = await response.transform(utf8.decoder).join();
      Map<String, dynamic> valueMap = json.decode(stringData);
      return valueMap;
    } on Exception catch (error) {
      print('catched ${error}');
      return null;
    }
  }
}
