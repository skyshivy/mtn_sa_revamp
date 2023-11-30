import 'dart:math';

import 'package:mtn_sa_revamp/files/cryptor/cryptor.dart';

import 'package:mtn_sa_revamp/files/model/new_user_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class NewRegistrartionVm {
  Future<NewUserRegistrationModel> register(
      String msisdn, String secCounter) async {
    String encryptedPassword = Cryptom().text("Oem@L#@1");

    Random random = Random();
    int randomNumber = random.nextInt(1000000000);

    var myPost = {
      "msisdn": msisdn,
      "encryptedPassword": encryptedPassword,
      "language": StoreManager().language,
      "clientTxnId": '$randomNumber',
      "userName": msisdn,
      "email": "",
      "categoryId": "137",
      "securityCounter": secCounter,
    };

    var parts = [];

    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? map =
        await ServiceCall().post(newUserRegistrationUrl, formData);
    if (map != null) {
      NewUserRegistrationModel model = NewUserRegistrationModel.fromJson(map);
      StoreManager().securityToken = model.responseMap?.secToc ?? '';
      return model;
    } else {
      return NewUserRegistrationModel();
    }
  }
}
