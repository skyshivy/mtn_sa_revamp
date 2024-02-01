import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

void parseUrl() async {
  printCustom(
      "========== Uri parser ============ ${Uri.parse(Uri.base.toString())}");
  var uri = Uri.parse(Uri.base.toString());
  printCustom("++++++++++++++${uri}");
  printCustom("hasPort++++++++++++++ ${uri.hasPort}");
  printCustom("host++++++++++++++ ${uri.host}");
  printCustom("origin++++++++++++++ ${uri.origin}");
  printCustom("port++++++++++++++ ${uri.port}");
  printCustom("queryParameters++++++++++++++${uri.hasQuery}");
  if (uri.hasQuery) {
    uri.queryParameters.forEach((k, v) {
      printCustom("key is == $k");
      printCustom("contain space ${v.replaceAll("+", " ")}");

      printCustom("value is == $v");
      if (k == 'data') {
        if (v.isEmpty) {
          return;
        }
        try {
          String decryptedValue =
              Decryptor().decryptWithAES(v.replaceAll(" ", "+"));
          printCustom("data decrypted value is  $decryptedValue");

          List<String> lst = decryptedValue.split('&');
          printCustom("lst ==== $lst");
          _getValueForTag(lst);
        } catch (e) {
          printCustom(
              "Else condition error occured in decrypt \n Error in decoding is =  ${e.toString()}\n");
        }

        return;
      } else {
        // clearData();
        printCustom("No such value found Else condition executed");
        return;
      }
    });
  } else {
    // clearData();
    printCustom("URL does not has hasQuery");
  }
}

clearData() {
  if (!StoreManager().isLoggedIn) {
    StoreManager().setMsisdn('0');
    ccid = '';
    StoreManager().setccid(ccid);
    userName = '';
    StoreManager().setUserName(userName);
    // password = '';
    // StoreManager().setPassword(password);
    channelId = '';
    StoreManager().setChannelId(channelId);
  }
}

Future<String> _getValueForTag(List<String> lst) async {
  String tempMsisdn = '';
  if (lst.isEmpty) {
    return '';
  }
  LoginController loginCont = Get.find();

  try {
    for (String item in lst) {
      List<String> newL = item.split('=');

      try {
        if (newL[0] == 'msisdn') {
          printCustom("msisdn = ${newL[1]}");
          var msisdn1 = newL[1];
          tempMsisdn = newL[1];
          //await StoreManager().setMsisdn(msisdn1);
        }
      } catch (e) {}

      try {
        if (newL[0] == 'ccusername') {
          //ccusername
          printCustom("ccid = ${newL[1]}");
          ccid = newL[1];
          StoreManager().setccid(ccid);
        }
      } catch (e) {}
      try {
        if (newL[0] == 'userName') {
          printCustom("userName = ${newL[1]}");
          userName = newL[1];
          StoreManager().setUserName(userName);
        }
      } catch (e) {}

      try {
        if (newL[0] == 'password') {
          printCustom("password = ${newL[1]}");
          //password = newL[1];
          //StoreManager().setPassword(password);
        }
      } catch (e) {}

      try {
        if (newL[0] == 'channel') {
          printCustom("channel = ${newL[1]}");
          channelId = newL[1];
          StoreManager().setChannelId(channelId);
        }
      } catch (e) {}
    }

    printCustom("SKY Msisdn = ${StoreManager().msisdn}");
    printCustom("SKY ccid = $ccid");
    printCustom("SKY userName = $userName");
    printCustom("SKY password = $password");
    printCustom("SKY channel = $channelId");
  } catch (e) {
    printCustom("Some thing went wrong === $e");
  }
  if (!StoreManager().isLoggedIn) {
    printCustom("Login issue user is auto login");
    loginCont.autoLogin(tempMsisdn);
    printCustom("StoreManager().msisdn ==== ${StoreManager().msisdn}");
    printCustom("Make here auto login for msisdn $tempMsisdn");
  } else {
    if (tempMsisdn == StoreManager().msisdn) {
      printCustom(
          "Login issue Redirection with same number so no login api call");
    } else {
      printCustom("Login issue user is re Auto login with different number");
      StoreManager().logout();
      await Future.delayed(const Duration(milliseconds: 500));
      loginCont.autoLogin(tempMsisdn);
    }
  }
  return '';
}
