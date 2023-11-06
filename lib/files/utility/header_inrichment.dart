import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';

void parseUrl() async {
  print("========== Uri parser ============ ${Uri.parse(Uri.base.toString())}");
  var uri = Uri.parse(Uri.base.toString());
  print("++++++++++++++${uri}");
  print("queryParameters++++++++++++++${uri.hasQuery}");
  if (uri.hasQuery) {
    uri.queryParameters.forEach((k, v) {
      print("key is == $k");
      print("contain space ${v.replaceAll("+", " ")}");

      print("value is == $v");
      if (k == 'data') {
        if (v.isEmpty) {
          return;
        }
        try {
          String decryptedValue =
              Decryptor().decryptWithAES(v.replaceAll(" ", "+"));
          print("data decrypted value is  $decryptedValue");

          List<String> lst = decryptedValue.split('&');
          print("lst ==== $lst");
          _getValueForTag(lst);
        } catch (e) {
          print(
              "Else condition error occured in decrypt \n Error in decoding is =  ${e.toString()}\n");
        }

        return;
      } else {
        clearData();
        print("Else condition executed");
        return;
      }
    });
  } else {
    password = '';
    clearData();
    print("URL does not has hasQuery");
  }
}

clearData() {
  if (!StoreManager().isLoggedIn) {
    StoreManager().setMsisdn('');
    ccid = '';
    StoreManager().setccid(ccid);
    userName = '';
    StoreManager().setUserName(userName);
    password = '';
    StoreManager().setPassword(password);
    channelId = '';
    StoreManager().setChannelId(channelId);
  }
}

Future<String> _getValueForTag(List<String> lst) async {
  if (lst.isEmpty) {
    return '';
  }
  LoginController loginCont = Get.find();

  try {
    for (String item in lst) {
      List<String> newL = item.split('=');

      try {
        if (newL[0] == 'msisdn') {
          print("msisdn = ${newL[1]}");
          var msisdn1 = newL[1];
          await StoreManager().setMsisdn(msisdn1);
        }
      } catch (e) {}

      try {
        if (newL[0] == 'ccid') {
          print("ccid = ${newL[1]}");
          ccid = newL[1];
          StoreManager().setccid(ccid);
        }
      } catch (e) {}
      try {
        if (newL[0] == 'userName') {
          print("userName = ${newL[1]}");
          userName = newL[1];
          StoreManager().setUserName(userName);
        }
      } catch (e) {}

      try {
        if (newL[0] == 'password') {
          print("password = ${newL[1]}");
          password = newL[1];
          StoreManager().setPassword(password);
        }
      } catch (e) {}
      try {
        if (newL[0] == 'channel') {
          print("channel = ${newL[1]}");
          channelId = newL[1];
          StoreManager().setChannelId(channelId);
        }
      } catch (e) {}
    }

    print("SKY Msisdn = ${StoreManager().msisdn}");
    print("SKY ccid = $ccid");
    print("SKY userName = $userName");
    print("SKY password = $password");
    print("SKY channel = $channelId");
  } catch (e) {
    print("Some thing went wrong === $e");
  }
  if (!StoreManager().isLoggedIn) {
    loginCont.autoLogin(StoreManager().msisdn);
    print("Make here auto login ");
  }
  return '';
}
