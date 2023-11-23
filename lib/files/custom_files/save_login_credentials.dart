import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Future<void> saveCredentialHere(PasswordValidationModel model) async {
  printCustom("1 saveCredentialHere ===================================");
  //var respMap = valueMap['responseMap'];

  ResponseMap? resp = model.responseMap;
  final prefs = await SharedPreferences.getInstance();
  printCustom("saveCredentialHere 1");
  prefs.setString('respDesc', resp?.respDesc ?? '');
  printCustom("saveCredentialHere 2");
  prefs.setString('srvType', resp?.srvType ?? '');
  printCustom("saveCredentialHere 3");
  prefs.setString('userIdEnc', resp?.userIdEnc ?? '');
  printCustom("saveCredentialHere 4");
  prefs.setString('userName', resp?.userName ?? '');
  printCustom("saveCredentialHere 5");
  prefs.setString('accessToken', resp?.accessToken ?? '');
  printCustom("saveCredentialHere 6");
  prefs.setString('userId', resp?.userId ?? '');
  printCustom("saveCredentialHere 7");
  prefs.setString('deviceId', resp?.deviceId ?? '');
  printCustom("saveCredentialHere 8");
  prefs.setString('clientTxnId', resp?.clientTxnId ?? '');
  printCustom("saveCredentialHere 9");
  //prefs.setInt('expiry', respMap['expiry']);
  prefs.setString('msisdn', resp?.msisdn ?? '');
  printCustom("saveCredentialHere 10");
  prefs.setString('txnId', resp?.txnId ?? '');
  printCustom("saveCredentialHere 11");
  prefs.setString('refreshToken', resp?.refreshToken ?? '');
  printCustom("saveCredentialHere 12");
  prefs.setBool('isLoggedIn', true);
  printCustom("saveCredentialHere 13");
  StoreManager().isLoggedIn = true;
  printCustom("saveCredentialHere 14");
  await StoreManager().setLoggedIn(true);
  printCustom("saveCredentialHere 15");

  printCustom("\nGoing to Store Credentials \n");
  await StoreManager().initStoreManager();
  printCustom("saveCredentialHere 16");
  return;
}
