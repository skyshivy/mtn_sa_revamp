import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/save_login_credentials.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/get_security_token_model.dart';
import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isVerifying = false.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString msisdn = ''.obs;
  String securityToken = '';
  RxString errorMessage = ''.obs;
  RxString otp = ''.obs;
  varifyMsisdnButtonAction() async {
    errorMessage.value = '';
    int len = StoreManager().msisdnLength;
    if (msisdn.value.length < (len)) {
      errorMessage.value = enterValidMsisdnStr;
      return;
    }
    printCustom("varifying Msisdn");
    isVerifying.value = true;
    await _validationMsisdn();
    isVerifying.value = false;
    printCustom("varified Msisdn");
  }

  editMsisdn() {
    errorMessage.value = '';
  }

  resetValue() async {
    errorMessage.value = '';
    isVerifying.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
  }

  Future<bool> verifyOtpButtonAction() async {
    errorMessage.value = '';
    int len = StoreManager().otpLength;
    if (otp.value.length < (len)) {
      errorMessage.value = enterValidOtpStr;
      return false;
    }

    var isConfirmed = await _confirmOtpApi();
    if (isConfirmed) {
      bool isGotSecurityToekn = await _securityToken();
      if (isGotSecurityToekn) {
        return await _passwordValidationToken();
      }
    }
    return false;
  }

  Future<String> _validationMsisdn() async {
    String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
    Map<String, dynamic> valueMap = json.decode(stringData);
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    if (model.responseMap?.respCode == 'SC0000') {
      await _generateOtp();
      printCustom("Existing user******");
    } else if (model.responseMap?.respCode == '100') {
      isMsisdnVarified.value = true;
      printCustom("New user*****");
    } else if (model.responseMap?.respCode == '101') {
      errorMessage.value = model.responseMap?.respDesc ?? '';
      printCustom("Invalid number*******");
    } else {
      errorMessage.value = model.responseMap?.respDesc ?? '';
      printCustom("Invalid number*******");
    }
    return "";
  }

  Future<void> _generateOtp() async {
    isVerifying.value = true;
    GenerateOtpModel result = await LoginVm().generateOtp(msisdn.value);
    isVerifying.value = false;
    if (result.statusCode == "SC0000") {
      isMsisdnVarified.value = true;
    } else {
      errorMessage.value = result.message;
      isMsisdnVarified.value = false;
    }

    printCustom("Generate otp api call here");
  }

  Future<bool> _confirmOtpApi() async {
    printCustom("Resu =Sky========");
    isVerifying.value = true;
    ConfirmOtpModel? model =
        await LoginVm().confirmOtp(msisdn.value, otp.value);
    printCustom(
        "Resu =Sky====model?.statusCode ${model?.statusCode}==model?.message ${model?.message}=");
    isVerifying.value = false;
    if (model?.statusCode == "SC0000") {
      return true;
    } else {
      errorMessage.value = model?.message ?? '';
      return false;
    }
  }

  Future<bool> _securityToken() async {
    isVerifying.value = true;
    GetSecurityTokenModel? res = await LoginVm().securityTokenApi();
    isVerifying.value = false;
    if (res != null) {
      if (res.statusCode == "SC0000") {
        securityToken = res.responseMap.securityCounter;
        StoreManager().securityToken = securityToken;
        return true;
      } else {
        errorMessage.value = res.statusCode;
        return false;
      }
    }
    errorMessage.value = someThingWentWrongStr;
    return false;
  }

  Future<bool> _passwordValidationToken({bool isAutoLogin = false}) async {
    isVerifying.value = true;
    Map<String, dynamic>? resut = await LoginVm().passwordValidation(
        securityToken, msisdn.value,
        isAutoLogin: isAutoLogin);
    isVerifying.value = false;
    if (resut != null) {
      PasswordValidationModel mode = PasswordValidationModel.fromJson(resut);
      if (mode.statusCode != 'SC0000') {
        Get.dialog(CustomAlertView(title: mode.message ?? ''));
        printCustom("Password validation fialed");
        return false;
      }
    }

    if (resut != null) {
      printCustom(
          "Before  credential here ===================================");
      await saveCredentialHere(resut);
      printCustom("save credential here ===================================");
      return true;
    } else {
      errorMessage.value = someThingWentWrongStr;
      return false;
    }
  }

  // saveCredentialHere(Map<String, dynamic> valueMap) async {
  //   var respMap = valueMap['responseMap'];
  //   final prefs = await SharedPreferences.getInstance();

  //   var loginSessionTimeStr = DateTime.now().toString();
  //   prefs.setString('loginSessionTime', loginSessionTimeStr);
  //   prefs.setString('respDesc', respMap['respDesc']);
  //   prefs.setString('srvType', respMap['srvType']);
  //   prefs.setString('userIdEnc', respMap['userIdEnc']);
  //   prefs.setString('userName', respMap['userName']);
  //   prefs.setString('accessToken', respMap['accessToken']);
  //   prefs.setString('userId', respMap['userId']);
  //   prefs.setString('deviceId', respMap['deviceId']);
  //   prefs.setString('clientTxnId', respMap['clientTxnId']);
  //   //prefs.setInt('expiry', respMap['expiry']);
  //   prefs.setString('msisdn', respMap['msisdn']);
  //   prefs.setString('txnId', respMap['txnId']);
  //   prefs.setString('refreshToken', respMap['refreshToken']);
  //   prefs.setBool('isLoggedIn', true);
  //   StoreManager().isLoggedIn = true;
  //   customPrint("\nGoing to Store Credentials \n");
  //   await StoreManager().initStoreManager();
  // }
  Future<void> autoLogin(String msisdn1) async {
    msisdn.value = msisdn1;
    String stringData = await LoginVm().subscribeMsisdn(msisdn1);
    Map<String, dynamic> valueMap = json.decode(stringData);
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    if (model.responseMap?.respCode == 'SC0000') {
      //await _generateOtp();
      await _autoLoginPassowrdValidation();
      printCustom("Existing user******");
    } else if (model.responseMap?.respCode == '100') {
      isMsisdnVarified.value = true;
      printCustom("New user*****");
    } else if (model.responseMap?.respCode == '101') {
      errorMessage.value = model.responseMap?.respDesc ?? '';
      printCustom("Invalid number*******");
    } else {
      errorMessage.value = model.responseMap?.respDesc ?? '';
      printCustom("Invalid number*******");
    }
  }

  Future<void> _autoLoginPassowrdValidation() async {
    bool isGotSecurityToekn = await _securityToken();
    if (isGotSecurityToekn) {
      await _passwordValidationToken(isAutoLogin: true);
    }
  }

  _autoLoginSecurityToken(bool isNewUser) {}
}
