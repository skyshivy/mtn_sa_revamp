import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_popup_widget.dart';
import 'package:mtn_sa_revamp/files/custom_files/save_login_credentials.dart';
import 'package:mtn_sa_revamp/files/model/buy_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_existing_model.dart';
import 'package:mtn_sa_revamp/files/model/new_user_otp_check_model.dart';
import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_price_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/confirm_otp_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/view_model/get_tune_price_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/new_registration_vm.dart';
import 'package:mtn_sa_revamp/files/model/get_security_token_model.dart';
import 'package:mtn_sa_revamp/files/view_model/get_security_token_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/new_user_otp_check_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/password_validation_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/set_tune_vm.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class BuyController extends GetxController {
  AppController appController = Get.find();
  RxBool isVerifying = false.obs;
  RxBool isVerifyingOtp = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isShowSubscriptionPlan = false.obs;
  RxBool isShowOtpView = false.obs;
  RxBool isBuySuccess = false.obs;
  RxString successMessage = ''.obs;
  RxBool isMsisdnVarified = false.obs;
  bool isNewUser = false;
  RxString otp = ''.obs;
  String securityCounter = '';
  String tuneCharge = '';
  RxString msisdn = ''.obs;

  late TuneInfo? info;

  customInit() {
    isShowSubscriptionPlan.value = false;
    isVerifying.value = false;
    errorMessage.value = '';
    isShowOtpView.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
    msisdn.value = '';
    isBuySuccess.value = false;
    successMessage.value = '';
    getTuneCharge();
  }

  onEditAction() {
    isVerifying.value = false;
    errorMessage.value = '';
    isShowOtpView.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
    isBuySuccess.value = false;
    successMessage.value = '';
  }

  getTuneCharge() {
    tuneCharge = StoreManager()
            .appSetting
            .responseMap
            ?.settings
            ?.others
            ?.tonePrice
            ?.attribute ??
        '';
  }

  msisdnValidation(TuneInfo? inf) async {
    // if (StoreManager().isLoggedIn) {
    //   isVerifying.value = true;
    //   customPrint("User is already loggedin plese direct buy");
    //   await getTunePriceAndBuyTune();

    //   return;
    // }

    isShowOtpView.value = false;
    info = inf;
    if (msisdn.value.length == StoreManager().msisdnLength) {
      isVerifying.value = true;
      String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
      Map<String, dynamic> valueMap = json.decode(stringData);
      isVerifying.value = true;
      SubscriberValidationModel model =
          SubscriberValidationModel.fromJson(valueMap);
      if (model.responseMap?.respCode == 'SC0000') {
        var resu = await _generateOtp(msisdn.value, false);
        isNewUser = false;
        isShowOtpView.value = true;
        isVerifying.value = false;
        //Get.dialog(BuyOtpView());

        printCustom("Existing user******");
      } else if (model.responseMap?.respCode == '100') {
        printCustom("New User*******");
        isNewUser = true;
        await getSecurityTokenForNew(msisdn.value);
        //getTunePrice();
        isShowOtpView.value = true;
        //Get.dialog(BuyOtpView());
      } else if (model.responseMap?.respCode == '101') {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        printCustom("Invalid number*******");
      } else {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        printCustom("Invalid number*******");
      }
    } else {
      errorMessage.value = pleaseEnterValidMsisdnStr;
    }
  }

  Future<GenerateOtpModel> _generateOtp(String msisdn, bool isNewUser) async {
    isVerifying.value = true;
    GenerateOtpModel result = await LoginVm().generateOtp(msisdn);

    if (result.statusCode == "SC0000") {
      //isMsisdnVarified.value = true;
    } else {
      errorMessage.value = result.message;
      isMsisdnVarified.value = false;
      isVerifying.value = false;
    }
    return result;
  }

  Future<void> getSecurityTokenForNew(String msisdn) async {
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;
      bool isRegistered =
          await NewRegistrartionVm().register(msisdn, securityCounter);
      isVerifying.value = false;
      if (isRegistered) {
        await _generateOtp(msisdn, true);
        return;
      } else {
        errorMessage.value = someThingWentWrongStr;
        isVerifying.value = false;
      }
      printCustom("NewRegistrartionVm status $isRegistered");
      return;
    }
    isVerifying.value = false;
    return;
  }

  Future<TonePriceModel> getTunePrice() async {
    errorMessage.value = '';
    String msisdn3 = '';
    if (StoreManager().isLoggedIn) {
      msisdn3 = StoreManager().msisdn;
    } else {
      msisdn3 = msisdn.value;
    }

    Map<String, dynamic>? map =
        await GetTunePrice().api(msisdn3, info?.toneId ?? '', '3');
    if (map != null) {
      //try {
      TonePriceModel model = TonePriceModel.fromJson(map);
      printCustom("status code is ============== ${model.statusCode}");
      printCustom("sky status code is ============== ${model.statusCode}");
      return model;
      // } catch (e) {
      //   printCustom("error is ========${e}");
      //   TonePriceModel model = TonePriceModel(message: someThingWentWrongStr);
      //   return model;
      // }
    } else {
      TonePriceModel model = TonePriceModel(message: someThingWentWrongStr);
      return model;
    }
  }

  updateOtp(String value) {
    otp.value = value;
    errorMessage.value = '';
  }

  updateMsisdn(String value) {
    msisdn.value = value;
    errorMessage.value = '';
  }

  Future<void> newUserOtpCheck() async {
    isVerifyingOtp.value = true;
    Map<String, dynamic>? map = await NewUserOtpCheckVm()
        .check(otp.value, msisdn.value, StoreManager().securityToken);
    printCustom("newUserOtpCheck ========== ${map}");
    if (map != null) {
      NewUserCheckOtpModel model = NewUserCheckOtpModel.fromJson(map);
      if (model.statusCode == 'SCOOOO') {
        StoreManager().setMsisdn(model.responseMap?.msisdn ?? '');
      } else {
        errorMessage.value = model.message ?? '';
      }
    } else {
      errorMessage.value = someThingWentWrongStr;
    }
    isVerifyingOtp.value = false;
  }

  Future<void> verifyingOtpCheck() async {
    errorMessage.value = '';
    if (otp.value.length == StoreManager().otpLength) {
      isVerifyingOtp.value = true;

      if (isNewUser) {
        await newUserOtpCheck();
      } else {
        ConfirmOtpExistingModel res =
            await ConfirmOtpVM().confirm(msisdn.value, otp.value);
        printCustom("res = ${res.statusCode}");
        if (res.statusCode == "SC0000") {
          await getSecurityTokenForOldUser();
          // TonePriceModel model = await getTunePrice();
          // if (model.statusCode == 'SC0000') {
          //   String subscriptionStatus =
          //       model.responseMap?.responseDetails?.first.subscriberStatus ??
          //           '';
          //   if (subscriptionStatus == "NA" || subscriptionStatus == "NA") {
          //     isShowSubscriptionPlan.value = true;
          //     isShowOtpView.value = false;
          //     printCustom("isShowSubscriptionPlan display here");
          //   } else {
          //     isShowSubscriptionPlan.value = false;
          //     await getSecurityTokenForOldUser();
          //     printCustom("make here setTune here or uncomment below line");
          //   }
          // } else {}
          //
        } else {
          isVerifyingOtp.value = false;
          errorMessage.value = res.message ?? '';
        }
      }

      return;
    }
    errorMessage.value = pleaseEnterAValidOtpStr;
  }

  Future<void> getSecurityTokenForOldUser() async {
    isShowOtpView.value = true;
    isShowSubscriptionPlan.value = false;
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;

      if (model.statusCode == "SC0000") {
        passwordValidation();
      } else {
        isVerifyingOtp.value = false;
        errorMessage.value = '';
      }
    }
  }

  Future<void> passwordValidation() async {
    Map<String, dynamic>? map = await PasswordValidationVm()
        .validatePassword(msisdn.value, securityCounter, false);
    if (map != null) {
      PasswordValidationModel model = PasswordValidationModel.fromJson(map);
      //await saveCredentialHere(model);
      print("model = $model");
      print("model.responseMap = ${model.responseMap}");
      print("model.responseMap?.msisdn = ${model.responseMap?.msisdn}");
      StoreManager().msisdn = model.responseMap?.msisdn ?? "";
      StoreManager().setAccessToken(model.responseMap?.accessToken ?? "");
      print("set 1 ${model.responseMap?.accessToken ?? ""}");
      StoreManager().setDeviceId(model.responseMap?.deviceId ?? "");
      print("set 2 ${model.responseMap?.deviceId ?? ""}");
      StoreManager().setMsisdn(model.responseMap?.msisdn ?? "");
      print("set 3 ${model.responseMap?.msisdn ?? ""}");
      StoreManager().setRefreshToken(model.responseMap?.refreshToken ?? "");
      print("set 4 ${model.responseMap?.refreshToken ?? ""}");
      StoreManager().setUserName(model.responseMap?.userName ?? "");
      print("set 5 ${model.responseMap?.userName ?? ""}");
      StoreManager().setLoggedIn(true);
      print("set 6");
      StoreManager().initStoreManager();
      print("set 7");
      printCustom("save credential here ===================================");

      // StoreManager().msisdn = model.responseMap?.msisdn ?? "";
      // StoreManager().setAccessToken(model.responseMap?.accessToken ?? "");
      // print("set 1");
      // StoreManager().setDeviceId(model.responseMap?.deviceId ?? "");
      // print("set 2");
      // StoreManager().setMsisdn(model.responseMap?.msisdn ?? "");
      // print("set 3");
      // StoreManager().setRefreshToken(model.responseMap?.refreshToken ?? "");
      // print("set 4");
      // StoreManager().setUserName(model.responseMap?.userName ?? "");
      // print("set 5");
      // StoreManager().setLoggedIn(true);
      // print("set 6");
      // StoreManager().initStoreManager();
      // print("set 7");
      // printCustom("save credential here ===================================");

      if (model.statusCode == 'SC0000') {
        getTunePriceAndBuyTune(info);
      } else {
        isVerifyingOtp.value = false;
        errorMessage.value = '';
      }
    }
  }

  Future<void> getTunePriceAndBuyTune(TuneInfo? info) async {
    errorMessage.value = '';
    this.info = info;
    isVerifying.value = true;

    TonePriceModel model = await getTunePrice();

    if (model.statusCode == 'SC0000') {
      ResponseDetail? responseDetail =
          model.responseMap?.responseDetails?.first;
      String packName = responseDetail?.packName ?? '';
      String status = responseDetail?.subscriberStatus ?? '';

      if ((status == 'NA') || (status == 'D') || (status == 'd')) {
        isShowOtpView.value = false;
        isShowSubscriptionPlan.value = true;
      } else {
        await setTune(packName);
      }
    } else {
      isBuySuccess.value = true;
      successMessage.value = model.message ?? '';
      isVerifyingOtp.value = false;
      isVerifying.value = false;
      errorMessage.value = model.message ?? someThingWentWrongStr;
    }
  }

  onConfirmSubscriptionPlan(String packName) async {
    isShowOtpView.value = !StoreManager().isLoggedIn;
    isShowSubscriptionPlan.value = false;
    printCustom("Pack name is $packName");
    await setTune(packName);
  }

  Future<void> setTune(String packName) async {
    BuyTuneModel res = await SetTuneVM().set(info ?? TuneInfo(), packName);
    packName = '';
    if (res.statusCode == 'SC0000') {
      printCustom("Success buy tune api");
      isVerifyingOtp.value = false;
      isVerifying.value = false;
      isBuySuccess.value = true;
      successMessage.value = res.message ?? '';
    } else {
      printCustom("set tune failed");
      isVerifyingOtp.value = false;
      errorMessage.value = res.responseMap?.responseMessage ??
          res.message ??
          someThingWentWrongStr;
      isVerifying.value = false;
    }
  }
}
