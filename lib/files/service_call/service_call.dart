import 'dart:convert';
import 'dart:html';

import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:universal_io/io.dart';

class ServiceCall {
  final client = HttpClient();

  getSetting(String url) async {
    try {
      var request = await client.getUrl(Uri.parse(url));
      HttpClientResponse response1 = await request.close();
      final stringData = await response1.transform(utf8.decoder).join();
      print("Url is $url");
      print("App Setting resp code is ${response1.statusCode}");
      if (response1.statusCode == 200) {
        Map<String, dynamic> valueMap = json.decode(stringData);
        AppSettingModel setting = AppSettingModel.fromJson(valueMap);
        StoreManager().appSetting = setting;
      }
    } catch (error) {
      print("error for url #${url}");
      print("error =   =  ${error}");
    }
  }
}
