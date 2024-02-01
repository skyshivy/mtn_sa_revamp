import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/otp_timer_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/save_login_credentials.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/get_security_token_model.dart';
import 'package:mtn_sa_revamp/files/model/new_user_model.dart';
import 'package:mtn_sa_revamp/files/model/new_user_otp_check_model.dart';
import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/get_security_token_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/new_registration_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/new_user_otp_check_vm.dart';

class LoginController extends GetxController {
  RxBool isVerifying = false.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString msisdn = ''.obs;
  String securityToken = '';

  String securityCounter = '';
  RxString errorMessage = ''.obs;
  RxString otp = ''.obs;
  bool isNewUser = false;
  //OtpTimerController timerCont = Get.find();
  varifyMsisdnButtonAction() async {
    errorMessage.value = '';
    int len = StoreManager().msisdnLength;
    if (msisdn.value.length < (len)) {
      errorMessage.value = enterValidMsisdnStr.tr;
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
      errorMessage.value = enterValidOtpStr.tr;
      return false;
    }
    printCustom("on confirm  verifyOtpButtonAction   before _confirmOtpApi");
    var isConfirmed = await _confirmOtpApi();
    printCustom(
        "on confirm  verifyOtpButtonAction   after _confirmOtpApi == value is $isConfirmed");

    if (isConfirmed) {
      bool isGotSecurityToekn = await _securityToken();
      printCustom("on confirm after _securityToken = $isGotSecurityToekn");
      if (isGotSecurityToekn) {
        printCustom("on confirm before _passwordValidationToken");
        return await _passwordValidationToken();
      }
    }
    printCustom("Not confirm otp api");
    return false;
  }

  Future<String> _validationMsisdn() async {
    String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
    Map<String, dynamic> valueMap = json.decode(stringData);
    isNewUser = false;
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    if (model.statusCode == "SC0000") {
      if (model.responseMap?.respCode == 'SC0000') {
        await generateOtp();
        otpController.initTimer();
        printCustom("Existing user******");
      } else if (model.responseMap?.respCode == '100') {
        isMsisdnVarified.value = true;
        isNewUser = true;
        printCustom("New user*****");
        await getSecurityTokenForNew(msisdn.value);
      } else if (model.responseMap?.respCode == '101') {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        isVerifying.value = false;
        printCustom("Invalid number*******");
      } else {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        isVerifying.value = false;
        printCustom("Invalid number*******");
      }
    } else {
      errorMessage.value = model.responseMap?.respDesc ?? '';
      isVerifying.value = false;
    }
    return "";
  }

  Future<bool> generateOtp() async {
    isVerifying.value = true;
    // if (isNewUser) {
    //   newUserOtpCheck();
    // } else {

    GenerateOtpModel result = await LoginVm().generateOtp(msisdn.value);
    isVerifying.value = false;
    if (result.statusCode == "SC0000") {
      isMsisdnVarified.value = true;
    } else {
      errorMessage.value = result.message;
      isMsisdnVarified.value = false;
    }

    //}

    printCustom("Generate otp api call here");
    return true;
  }

  Future<bool> newUserOtpCheck(String securityCounter) async {
    isVerifying.value = true;
    Map<String, dynamic>? map = await NewUserOtpCheckVm()
        .check(otp.value, msisdn.value, securityCounter);
    printCustom("newUserOtpCheck ========== ${map}");
    printCustom("sky =========4");
    isVerifying.value = false;
    if (map != null) {
      printCustom("sky =========5");
      NewUserCheckOtpModel model = NewUserCheckOtpModel.fromJson(map);
      if (model.statusCode == 'SC0000') {
        printCustom("sky =========6");
        isMsisdnVarified.value = true;
        return true;
      } else {
        printCustom("sky =========7");
        errorMessage.value = model.message ?? '';
        isMsisdnVarified.value = true;
        isVerifying.value = false;
        return false;
      }
    } else {
      errorMessage.value = someThingWentWrongStr.tr;
      isMsisdnVarified.value = false;
      isVerifying.value = false;
      return false;
    }
  }

  Future<bool> _confirmOtpApi() async {
    printCustom("Resu =Sky========");
    isVerifying.value = true;
    if (isNewUser) {
      printCustom("sky =========0");
      bool isLoggedInSuccess = await newUserOtpCheck(securityCounter);
      printCustom("sky =========1");
      return isLoggedInSuccess;
    } else {
      printCustom("sky =========2");
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
    errorMessage.value = someThingWentWrongStr.tr;
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
      PasswordValidationModel model = PasswordValidationModel.fromJson(resut);
      if (model.statusCode == "SC0000") {
        printCustom(
            "Before  credential here ===================================");
        await saveCredentialHere(model);
        printCustom("save credential here ===================================");
        return true;
      } else {
        errorMessage.value = someThingWentWrongStr.tr;
        return false;
      }
    } else {
      errorMessage.value = someThingWentWrongStr.tr;
      return false;
    }
  }

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
      await autoLoginSecurityTokenForNewUser(msisdn.value);
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

  autoLoginSecurityTokenForNewUser(String msisdn) async {
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;
      NewUserRegistrationModel newUserModel = await NewRegistrartionVm()
          .register(msisdn, securityCounter, sendOtp: false);

      if (newUserModel.statusCode == 'SC0000') {
        _autoLoginPassowrdValidation();
      } else {
        errorMessage.value = newUserModel.message ?? someThingWentWrongStr.tr;
        isVerifying.value = false;
        isMsisdnVarified.value = false;
      }
    } else {
      isVerifying.value = false;
      isMsisdnVarified.value = false;
      errorMessage.value = someThingWentWrongStr.tr;
      return;
    }
  }

//=======================New user==================

  Future<void> getSecurityTokenForNew(String msisdn) async {
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;
      NewUserRegistrationModel newUserModel =
          await NewRegistrartionVm().register(msisdn, securityCounter);

      if (newUserModel.statusCode == 'SC0000') {
        otpController.initTimer();
        securityCounter = newUserModel.responseMap?.secToc ?? '';
        isVerifying.value = false;
        isMsisdnVarified.value = true;
      } else {
        errorMessage.value = newUserModel.message ?? someThingWentWrongStr.tr;
        isVerifying.value = false;
        isMsisdnVarified.value = false;
      }
    } else {
      isVerifying.value = false;
      isMsisdnVarified.value = false;
      errorMessage.value = someThingWentWrongStr.tr;
      return;
    }
  }

  //_autoLoginSecurityToken(bool isNewUser) {}
}
