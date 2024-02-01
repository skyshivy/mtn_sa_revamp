import 'dart:convert';
import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_popup_widget.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_tune_charge.dart';
import 'package:mtn_sa_revamp/files/custom_files/save_login_credentials.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/buy_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_existing_model.dart';
import 'package:mtn_sa_revamp/files/model/custom_validity_model.dart';
import 'package:mtn_sa_revamp/files/model/new_user_model.dart';
import 'package:mtn_sa_revamp/files/model/new_user_otp_check_model.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/password_validation_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_price_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/buy_music_channel_api.dart';
import 'package:mtn_sa_revamp/files/view_model/confirm_otp_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
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
  RxBool isLoagTuneCharge = false.obs;
  RxString otp = ''.obs;
  String securityCounter = '';
  RxString tuneCharge = enterMobileNumberStr.obs;
  String storeTuneCharge = '0';
  RxBool isUpgradeSelected = false.obs;
  RxBool isHideUpgrade = true.obs;
  RxString msisdn = ''.obs;
  bool isGotTunePrice = false;
  late TuneInfo? info;
  bool isBuyMusicChannel = false;
  String crbtVipOfferCode = '';
  Others? others = StoreManager().appSetting?.responseMap?.settings?.others;
  TonePriceModel? tonePriceModel;
  //List<CustomValidtyModel> _validityModel = [];
  @override
  void onInit() {
    super.onInit();
  }

  customInit() {
    others = StoreManager().appSetting?.responseMap?.settings?.others;
    crbtVipOfferCode = others?.crbtVipOfferCode?.attribute ?? '';
    printCustom("crbtVipOfferCode customInit $crbtVipOfferCode");
    tonePriceModel = null;
    isBuyMusicChannel = false;
    isGotTunePrice = false;
    if (StoreManager().isLoggedIn) {
      tuneCharge.value = '';
    } else {
      tuneCharge.value = enterMobileNumberStr;
    }
    storeTuneCharge = tuneCharge.value;
    isHideUpgrade.value = true;
    isUpgradeSelected.value = false;
    isShowSubscriptionPlan.value = false;
    isVerifying.value = false;
    errorMessage.value = '';
    isShowOtpView.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
    msisdn.value = '';
    isBuySuccess.value = false;
    successMessage.value = '';
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

  getTuneCharge(TuneInfo info) async {
    this.info = info;
    printCustom("SKy 123-------");
    String msis = '';
    if (StoreManager().isLoggedIn) {
      msis = StoreManager().msisdn;
    } else {
      msis = msisdn.value;
    }

    if (msis.isEmpty) {
      printCustom("Msisdn is empty so can not call get tune price api");
      return false;
    }
    isLoagTuneCharge.value = true;
    isVerifying.value = true;
    printCustom("Get tune price called");
    String number = '';
    if (StoreManager().isLoggedIn) {
      number = StoreManager().msisdn;
    } else {
      number = msisdn.value;
    }

    tonePriceModel = await _getTunePrice();

    if (tonePriceModel?.statusCode == "SC0000") {
    } else {
      isVerifying.value = false;
      errorMessage.value = tonePriceModel?.message ??
          tonePriceModel?.responseMap?.description ??
          someThingWentWrongStr;
      tonePriceModel = null;
      return false;
    }
    //if (StoreManager().packStatus == null) {
    PackStatusModel crbtPackStatusModel = await getPackStatusApiCall(number);
    PackStatusModel rrbtPackStatusModel =
        await getPackStatusApiCall(number, isCrbt: false);
    if (crbtPackStatusModel.statusCode == "SC0000") {
    } else {
      isVerifying.value = false;
      errorMessage.value = crbtPackStatusModel.message ??
          tonePriceModel?.responseMap?.description ??
          someThingWentWrongStr;
      printCustom("Some thing went wrong while fetching tune price");
      return false;
    }
    //}
    printCustom("Pack name = ${StoreManager().crbtPackStatus?.packName}");
    printCustom("crbtVipOfferCode = $crbtVipOfferCode");
    isVerifying.value = false;
    isLoagTuneCharge.value = false;
    isHideUpgrade.value = false;
    if (tonePriceModel?.statusCode == "SC0000") {
      String amount =
          tonePriceModel?.responseMap?.responseDetails?.first.amount ?? '0';
      String status = StoreManager().crbtPackStatus?.packName ?? '';
      //tonePriceModel?.responseMap?.responseDetails?.first.subscriberStatus ?? ''; //

      //isHideUpgrade.value = (amount == "0");
      //if ((status == 'NA') || (status == 'D') || (status == 'd')) {
      if (status == crbtVipOfferCode) {
        isHideUpgrade.value = true;
      }
      // else {
      //   isHideUpgrade.value = (amount == "0");
      // }
      if (isBuyMusicChannel) {
        isHideUpgrade.value = true;
      }
      printCustom("AMount is $amount");
      printCustom("Pack name is $status");
      String packName1 =
          tonePriceModel?.responseMap?.responseDetails?.first.packName ?? '';
      tuneCharge.value = await customTuneChanrge(packName1, amount);
      storeTuneCharge = tuneCharge.value;
      printCustom("Pack name is1 $status");
      if (status.isEmpty) {
        printCustom("Pack name is2 $status");
        isHideUpgrade.value = true;

        if (rrbtPackStatusModel.statusCode == 'SC0000') {
          String rrbtPackName =
              rrbtPackStatusModel.responseMap?.packStatusDetails?.packName ??
                  '';
          if (rrbtPackName.isNotEmpty) {
            isHideUpgrade.value = true;
          }
        }
      }

      //rrbtPackStatusModel.message
      return true;
    } else {
      isHideUpgrade.value = true;
      errorMessage.value = tonePriceModel?.message ??
          tonePriceModel?.responseMap?.description ??
          someThingWentWrongStr;
      printCustom("Some thing went wrong while fetching tune price");
      return false;
    }

    // isVerifying.value = false;
    // isLoagTuneCharge.value = false;
/*
    Map<String, dynamic>? map = await //GetTunePrice().api(msis, toneId, '3');
    isVerifying.value = false;
    isLoagTuneCharge.value = false;
    if (map != null) {
      TonePriceModel mode = TonePriceModel.fromJson(map);
      printCustom("model=======$mode");

      if (mode.statusCode == "SC0000") {
        String amount = mode.responseMap?.responseDetails?.first.amount ?? '0';
        String status =
            mode.responseMap?.responseDetails?.first.subscriberStatus ?? '';

        isHideUpgrade.value = (amount == "0");
        if ((status == 'NA') || (status == 'D') || (status == 'd')) {
          isHideUpgrade.value = true;
        } else {
          isHideUpgrade.value = (amount == "0");
        }
        if (isBuyMusicChannel) {
          isHideUpgrade.value = true;
        }
        printCustom("AMount is $amount");
        String packName1 =
            mode.responseMap?.responseDetails?.first.packName ?? '';
        tuneCharge.value = await customTuneChanrge(packName1, amount);

        return true;
      } else {
        errorMessage.value = mode.message ??
            mode.responseMap?.description ??
            someThingWentWrongStr;
        printCustom("Some thing went wrong while fetching tune price");
        return false;
      }
      
    }

    */
  }

  msisdnValidation(TuneInfo? inf, {bool isBuyMusicChannel = false}) async {
    this.isBuyMusicChannel = isBuyMusicChannel;
    if (isBuyMusicChannel) {
      isHideUpgrade.value = false;
    }
    // if (StoreManager().isLoggedIn) {
    //   isVerifying.value = true;
    //   customPrint("User is already loggedin plese direct buy");
    //   await getTunePriceAndBuyTune();

    //   return;
    // }
    if (isGotTunePrice) {
      isShowOtpView.value = false;

      info = inf;
      if (msisdn.value.length == StoreManager().msisdnLength) {
        isVerifying.value = true;
        String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
        Map<String, dynamic> valueMap = json.decode(stringData);
        isVerifying.value = true;
        SubscriberValidationModel model =
            SubscriberValidationModel.fromJson(valueMap);
        if (model.statusCode == "SC0000") {
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
            isVerifying.value = false;
            printCustom("Invalid number*******");
          } else {
            errorMessage.value = model.responseMap?.respDesc ?? '';
            isVerifying.value = false;
            printCustom("Invalid number*******");
          }
        } else {
          errorMessage.value = pleaseEnterValidMsisdnStr.tr;
          isVerifying.value = false;
        }
      }
    } else {
      if (!StoreManager().isLoggedIn) {
        if (msisdn.isEmpty) {
          errorMessage.value = enterMobileNumberStr;
          return;
        }
      }
      isGotTunePrice = await getTuneCharge(inf ?? TuneInfo());
    }

    // } else {
    //   printCustom("getTunePrice not success");
    // }
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
      NewUserRegistrationModel newUserModel =
          await NewRegistrartionVm().register(msisdn, securityCounter);
      if (newUserModel.statusCode == 'SC0000') {
        otpController.initTimer();
        securityCounter = newUserModel.responseMap?.secToc ?? '';
        isVerifying.value = false;
        isShowOtpView.value = true;
      } else {
        errorMessage.value = newUserModel.message ?? someThingWentWrongStr.tr;
        isVerifying.value = false;
        isShowOtpView.value = false;
      }
    } else {
      isVerifying.value = false;
      isShowOtpView.value = false;
      errorMessage.value = someThingWentWrongStr.tr;
      return;
    }
  }

/*
  Future<void> getSecurityTokenForNew(String msisdn) async {
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;
      bool isRegistered = false;
      NewUserRegistrationModel newUserModel =
          await NewRegistrartionVm().register(msisdn, securityCounter);
      if (newUserModel.statusCode == "SC0000") {
        isRegistered = true;
        StoreManager().securityCounter = newUserModel.responseMap?.secToc ?? '';
        securityCounter = newUserModel.responseMap?.secToc ?? '';
      }
      isVerifying.value = false;
      if (isRegistered) {
        //await _generateOtp(msisdn, true);
        isVerifying.value = true;
        return;
      } else {
        errorMessage.value = someThingWentWrongStr.tr;
        isVerifying.value = false;
      }
      printCustom("NewRegistrartionVm status $isRegistered");
      return;
    }
    isVerifying.value = false;
    return;
  }
*/
  Future<TonePriceModel> _getTunePrice() async {
    errorMessage.value = '';
    String msisdn3 = '';
    if (StoreManager().isLoggedIn) {
      msisdn3 = StoreManager().msisdn;
    } else {
      msisdn3 = msisdn.value;
    }
    if (tonePriceModel != null) {
      return tonePriceModel!;
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
      //   TonePriceModel model = TonePriceModel(message: someThingWentWrongStr.tr);
      //   return model;
      // }
    } else {
      TonePriceModel model = TonePriceModel(message: someThingWentWrongStr.tr);
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
      if (model.statusCode == 'SC0000') {
        StoreManager().setMsisdn(model.responseMap?.msisdn ?? '0');

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
      } else {
        errorMessage.value = model.message ?? '';
      }
    } else {
      errorMessage.value = someThingWentWrongStr.tr;
    }
    isVerifyingOtp.value = true;
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
        } else {
          isVerifyingOtp.value = false;
          errorMessage.value = res.message ?? '';
        }
      }
      return;
    }
    errorMessage.value = pleaseEnterAValidOtpStr.tr;
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

      if (model.statusCode == 'SC0000') {
        printCustom("save credential here ===================================");
        await saveCredentialHere(model);
        getTunePriceAndBuyTune(info);
      } else {
        printCustom("password validation failed");
        isVerifyingOtp.value = false;
        errorMessage.value = someThingWentWrongStr.tr;
      }
    }
  }

  Future<void> getTunePriceAndBuyTune(TuneInfo? info,
      {bool isBuyMusicChannel = false}) async {
    this.isBuyMusicChannel = isBuyMusicChannel;

    errorMessage.value = '';
    this.info = info;
    isVerifying.value = true;
    isHideUpgrade.value = false;
    TonePriceModel tonePriceModel = await _getTunePrice();
    if (StoreManager().crbtPackStatus == null) {
      PackStatusModel crbtPackStatusModel =
          await getPackStatusApiCall(StoreManager().msisdn);
      PackStatusModel rrbtPackStatusModel =
          await getPackStatusApiCall(StoreManager().msisdn, isCrbt: false);
      if (crbtPackStatusModel.statusCode == 'SC0000') {
      } else {
        isBuySuccess.value = true;
        successMessage.value = tonePriceModel.message ?? '';
        isVerifyingOtp.value = false;
        isVerifying.value = false;
        errorMessage.value = tonePriceModel.message ?? someThingWentWrongStr.tr;
        return;
      }
    }

    printCustom("Pack name = ${StoreManager().crbtPackStatus?.packName}");
    printCustom("crbtVipOfferCode = $crbtVipOfferCode");
    if (tonePriceModel.statusCode == 'SC0000') {
      ResponseDetail? responseDetail =
          tonePriceModel.responseMap?.responseDetails?.first;
      String packName = responseDetail?.packName ?? '';
      String crbtStatus = StoreManager().crbtPackStatus?.packName ?? "";
      String rrbtStatus = StoreManager().rrbtPackStatus?.packName ?? "";
      ''; //responseDetail?.subscriberStatus ?? '';
//tonePriceModel?.responseMap?.responseDetails?.first.subscriberStatus ?? ''; //
      // if ((status == 'NA') || (status == 'D') || (status == 'd')) {
      printCustom("\n-\n-\nCrbt pack name = $crbtStatus");
      printCustom("Rrbt pack name = $rrbtStatus\n-\n-\n");

      if (crbtStatus == crbtVipOfferCode) {
        isHideUpgrade.value = true;
        packName = crbtVipOfferCode;
      }

      if (crbtStatus.isEmpty) {
        if (rrbtStatus.isNotEmpty) {
          isHideUpgrade.value = true;
          isShowOtpView.value = false;
          isShowSubscriptionPlan.value = false;
          await setTune(rrbtStatus, priority: "1");
        } else {
          isHideUpgrade.value = true;
          isShowOtpView.value = false;
          isShowSubscriptionPlan.value = true;
        }
      } else {
        if (isBuyMusicChannel) {
          await buyMusicChannel();
        } else {
          await setTune(packName);
        }
      }
    } else {
      isBuySuccess.value = true;
      successMessage.value = tonePriceModel.message ?? '';
      isVerifyingOtp.value = false;
      isVerifying.value = false;
      errorMessage.value = tonePriceModel.message ?? someThingWentWrongStr.tr;
    }
  }

  onConfirmSubscriptionPlan(String packName) async {
    isShowOtpView.value = !StoreManager().isLoggedIn;
    isShowSubscriptionPlan.value = false;
    printCustom("Pack name is $packName");
    if (isBuyMusicChannel) {
      await buyMusicChannel();
    } else {
      await setTune(packName);
    }
  }

  Future<void> buyMusicChannel() async {
    BuyTuneModel mode = await buyMusicChannelApi(info?.toneId ?? '');
    if (mode.statusCode == 'SC0000') {
      printCustom("Success buy tune api");
      isVerifyingOtp.value = false;
      isVerifying.value = false;
      isBuySuccess.value = true;
      successMessage.value = mode.message ?? '';
    } else {
      printCustom("set tune failed");
      isVerifyingOtp.value = false;
      errorMessage.value = mode.responseMap?.responseMessage ??
          mode.message ??
          someThingWentWrongStr.tr;
      isVerifying.value = false;
    }
  }

  Future<void> setTune(String packName, {String priority = "0"}) async {
    printCustom(
        "set tune called  isUpgradeSelected.value =${isUpgradeSelected.value}");
    printCustom("Setting tune for packName = $packName");
    String strPackName = '';
    if (isUpgradeSelected.value) {
      strPackName = others?.crbtVipOfferCode?.attribute ?? '';
    } else {
      strPackName = packName;
    }
    // await Future.delayed(Duration(seconds: 3));
    // BuyTuneModel res = BuyTuneModel(message: 'Success', statusCode: 'SC0000');
    BuyTuneModel res = await SetTuneVM().set(
        info ?? TuneInfo(), strPackName, priority,
        isPackUpgrade: isUpgradeSelected.value);
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
          someThingWentWrongStr.tr;
      isVerifying.value = false;
    }
  }
}
