import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Future<void> saveCredentialHere(PasswordValidationModel model) async {
  printCustom("1 saveCredentialHere ===================================");
  //var respMap = valueMap['responseMap'];

  ResponseMap? resp = model.responseMap;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  printCustom("saveCredentialHere 1");
  await prefs.setString('respDesc', resp?.respDesc ?? '');
  printCustom("saveCredentialHere 2");
  await prefs.setString('srvType', resp?.srvType ?? '');
  printCustom("saveCredentialHere 3");
  await prefs.setString('userIdEnc', resp?.userIdEnc ?? '');
  printCustom("saveCredentialHere 4");
  await prefs.setString('userName', resp?.userName ?? '');
  printCustom("saveCredentialHere 5");
  await prefs.setString('accessToken', resp?.accessToken ?? '');
  printCustom("saveCredentialHere 6");
  await prefs.setString('userId', resp?.userId ?? '');
  printCustom("saveCredentialHere 7");
  await prefs.setString('deviceId', resp?.deviceId ?? '');
  printCustom("saveCredentialHere 8");
  await prefs.setString('clientTxnId', resp?.clientTxnId ?? '');
  printCustom("saveCredentialHere 9 msisdn is ${resp?.msisdn ?? ''}");
  //prefs.setInt('expiry', respMap['expiry']);
  await prefs.setString('msisdn', resp?.msisdn ?? '');
  printCustom("saveCredentialHere 10");
  await prefs.setString('txnId', resp?.txnId ?? '');
  printCustom("saveCredentialHere 11");
  await prefs.setString('refreshToken', resp?.refreshToken ?? '');
  printCustom("saveCredentialHere 12");
  await prefs.setBool('isLoggedIn', true);
  printCustom("saveCredentialHere 13");
  StoreManager().isLoggedIn = true;
  StoreManager().msisdn = resp?.msisdn ?? '';
  printCustom("saveCredentialHere 14");
  await StoreManager().setLoggedIn(true);
  printCustom("saveCredentialHere 15");

  printCustom("\nGoing to Store Credentials \n");
  await StoreManager().initStoreManager();
  printCustom("saveCredentialHere 16");
  return;
}
