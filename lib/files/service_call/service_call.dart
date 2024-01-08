import 'dart:convert';
import 'dart:html';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/regenerate_model.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

import 'package:universal_io/io.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class ServiceCall {
  final client = HttpClient();
  bool stopMultiple = true;
  Future<void> getSetting(String url) async {
    if (!stopMultiple) {
      await Future.delayed(const Duration(milliseconds: 100));
      stopMultiple = true;
      return;
    }
    stopMultiple = false;

    if (StoreManager().appSetting == null) {
      try {
        var request = await client
            .getUrl(Uri.parse(url))
            .timeout(Duration(seconds: StoreManager().timeOutDuration));
        HttpClientResponse response1 = await request.close();
        final stringData = await response1.transform(utf8.decoder).join();
        printCustom("Url is $url");
        printCustom("App Setting resp code is ${response1.statusCode}");
        if (response1.statusCode == 200) {
          Map<String, dynamic> valueMap = json.decode(stringData);
          AppSettingModel setting = AppSettingModel.fromJson(valueMap);
          StoreManager().storeAppSettingModel(setting);
          StoreManager().appSetting = setting;
        }
      } catch (error) {
        printCustom("error for url $url");
        printCustom("error =   =  $error");
      }
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

  Future<Map<String, dynamic>?> post(String url, String? formData,
      {Map<String, dynamic>? jsonData}) async {
    var request = await client
        .postUrl(Uri.parse(url))
        .timeout(Duration(seconds: StoreManager().timeOutDuration));
    request = await CustomHeader().settingHeader(url, request);
    if (jsonData != null) {
      String jsonstringmap = json.encode(jsonData);
      print("print formed data $jsonstringmap");
      request.write(jsonstringmap);
    }
    if (formData != null) {
      request.write(formData);
    }
    HttpClientResponse response = await request.close();
    String stringData = '';
    stringData = await response.transform(utf8.decoder).join();
    printCustom(stringData);
    printCustom("resp code is ${response.statusCode}");
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

  Future<Map<String, dynamic>?> get(String url,
      {Map<String, String>? params}) async {
    try {
      var request = await client
          .getUrl(Uri.parse(url))
          .timeout(Duration(seconds: StoreManager().timeOutDuration));
      request = await CustomHeader().settingHeader(url, request);
      if (params != null) {
        for (var entry in params.entries) {
          print(entry.key);
          print(entry.value);
          request.headers.set(entry.key, entry.value, preserveHeaderCase: true);
        }
      }
      String stringData = '';
      HttpClientResponse response1 = await request.close();

      stringData = await response1.transform(utf8.decoder).join();
      printCustom(stringData);

      printCustom("resp code is ${response1.statusCode}");
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
      printCustom("error for url #${url}");
      printCustom("error =   =  ${error}");
      return null;
    }
  }

  Future<void> regenarateTokenFromOtherClass() async {
    Map<String, dynamic> res = await reGeneratToken();
    RegenTokenModel model = RegenTokenModel.fromJson(res);
    if (model.statusCode == 'SC0000') {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      StoreManager().setAccessToken(model.responseMap?.accessToken ?? '');
      StoreManager().setRefreshToken(model.responseMap?.refreshToken ?? '');
      // await prefs.setString(
      //     "refreshToken", model.responseMap?.refreshToken ?? '');
      StoreManager().accessToken = model.responseMap?.accessToken ?? '';
      StoreManager().refreshToken = model.responseMap?.refreshToken ?? "";
      await Future.delayed(const Duration(milliseconds: 300));
    } else {
      AppController appCont = Get.find();
      appCont.isLoggedIn.value = false;
      StoreManager().logout();
      print("Logout called from sercice call if reGeneratToken fails");
      //html.window.location.reload();
    }
    printCustom("======Regene token ====== ${model.statusCode}");
    return;
  }

  reGeneratToken() async {
    String refreshToken = StoreManager().refreshToken;
    String accessToken = StoreManager().accessToken;

    String url = regenTokenUrl;
    printCustom("3url used currently is $url");

    var parts = [];
    var body = {'refreshToken': refreshToken};
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    printCustom("\nformed data is \n$formData\n");
    printCustom("line 41");

    var request = await client.postUrl(Uri.parse(url));

    printCustom("line 45");

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
        printCustom("Logut in case of regen");
      }
      final stringData = await response.transform(utf8.decoder).join();
      Map<String, dynamic> valueMap = json.decode(stringData);
      return valueMap;
    } on Exception catch (error) {
      printCustom('catched ${error}');
      return null;
    }
  }
}
