import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

void parseUrl() {
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
          if (!StoreManager().isLoggedIn) {
            print("Make here auto login ");
          }
        } catch (e) {
          print("Else condition error occured in decrypt");
        }

        return;
      } else {
        print("Else condition executed");
        return;
      }
    });
  } else {
    print("URL does not has hasQuery");
  }
}

Future<void> _getValueForTag(List<String> lst) async {
  if (lst.isEmpty) {
    return;
  }
  String msisdn = '';
  String ccid = '';
  String userName = '';
  String password = '';
  String channel = '';

  try {
    for (String item in lst) {
      List<String> newL = item.split('=');

      try {
        if (newL[0] == 'msisdn') {
          print("msisdn = ${newL[1]}");
          msisdn = newL[1];
        }
      } catch (e) {}

      try {
        if (newL[0] == 'ccid') {
          print("ccid = ${newL[1]}");
          ccid = newL[1];
        }
      } catch (e) {}
      try {
        if (newL[0] == 'userName') {
          print("userName = ${newL[1]}");
          userName = newL[1];
        }
      } catch (e) {}

      try {
        if (newL[0] == 'password') {
          print("password = ${newL[1]}");
          password = newL[1];
        }
      } catch (e) {}
      try {
        if (newL[0] == 'channel') {
          print("channel = ${newL[1]}");
          channel = newL[1];
        }
      } catch (e) {}
    }
    print("SKY Msisdn = $msisdn");
    print("SKY ccid = $ccid");
    print("SKY userName = $userName");
    print("SKY password = $password");
    print("SKY channel = $channel");
  } catch (e) {
    print("Some thing went wrong === $e");
  }
}
