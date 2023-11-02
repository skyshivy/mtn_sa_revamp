import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCredentialHere(Map<String, dynamic> valueMap) async {
  var respMap = valueMap['responseMap'];
  final prefs = await SharedPreferences.getInstance();

  var loginSessionTimeStr = DateTime.now().toString();
  prefs.setString('loginSessionTime', loginSessionTimeStr);
  prefs.setString('respDesc', respMap['respDesc']);
  prefs.setString('srvType', respMap['srvType']);
  prefs.setString('userIdEnc', respMap['userIdEnc']);
  prefs.setString('userName', respMap['userName']);
  prefs.setString('accessToken', respMap['accessToken']);
  prefs.setString('userId', respMap['userId']);
  prefs.setString('deviceId', respMap['deviceId']);
  prefs.setString('clientTxnId', respMap['clientTxnId']);
  //prefs.setInt('expiry', respMap['expiry']);
  prefs.setString('msisdn', respMap['msisdn']);
  prefs.setString('txnId', respMap['txnId']);
  prefs.setString('refreshToken', respMap['refreshToken']);
  prefs.setBool('isLoggedIn', true);
  StoreManager().isLoggedIn = true;
  await StoreManager().setLoggedIn(true);

  print("\nGoing to Store Credentials \n");
  await StoreManager().initStoreManager();
}
