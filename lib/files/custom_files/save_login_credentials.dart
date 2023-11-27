import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Future<void> saveCredentialHere(PasswordValidationModel model) async {
  printCustom("1 saveCredentialHere ===================================");
  printCustom("model = $model");
  printCustom("model.responseMap = ${model.responseMap}");
  printCustom("model.responseMap?.msisdn = ${model.responseMap?.msisdn}");
  StoreManager().msisdn = model.responseMap?.msisdn ?? "";
  StoreManager().setAccessToken(
      "accessToken default"); //(model.responseMap?.accessToken) ?? "accessToken");
  printCustom("set 1 ${model.responseMap?.accessToken ?? ""}");
  StoreManager().setDeviceId(
      " deviceId default"); //(model.responseMap?.deviceId) ?? "deviceId");
  printCustom("set 2 ${(model.responseMap?.deviceId) ?? ""}");
  StoreManager().setMsisdn(
      "353453535 default"); //(model.responseMap?.msisdn) ?? "msisdn");
  printCustom("set 3 ${model.responseMap?.msisdn ?? ""}");
  StoreManager().setRefreshToken(
      'refreshToken default'); //(model.responseMap?.refreshToken) ?? "refreshToken");
  printCustom("set 4 ${model.responseMap?.refreshToken ?? ""}");
  StoreManager().setUserName(
      "userName default"); //(model.responseMap?.userName) ?? "userName");
  printCustom("set 5 ${model.responseMap?.userName ?? ""}");
  StoreManager().setLoggedIn(true);
  printCustom("set 6");
  await StoreManager().initStoreManager();
  StoreManager().setLoggedIn(true);
  printCustom("set 7");
  printCustom("saveCredentialHere 16");
  return;
}
