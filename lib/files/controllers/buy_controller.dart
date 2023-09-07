import 'dart:convert';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
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

class BuyController extends GetxController {
  AppController appController = Get.find();
  RxBool isVerifying = false.obs;
  RxBool isVerifyingOtp = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isShowOtpView = false.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString otp = ''.obs;
  String securityCounter = '';
  RxString msisdn = '9923964719'.obs;
  late TuneInfo? info;

  customInit() {
    isVerifying.value = false;
    errorMessage.value = '';
    isShowOtpView.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
    msisdn.value = '9923964719';
  }

  onEditAction() {
    isVerifying.value = false;
    errorMessage.value = '';
    isShowOtpView.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
  }

  msisdnValidation(TuneInfo? inf) async {
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
        await _generateOtp(msisdn.value);
        isShowOtpView.value = true;
        isVerifying.value = false;
        //Get.dialog(BuyOtpView());

        print("Existing user******");
      } else if (model.responseMap?.respCode == '100') {
        print("New User*******");

        await getSecurityToken(msisdn.value);
        //getTunePrice();
        isShowOtpView.value = true;
        //Get.dialog(BuyOtpView());
      } else if (model.responseMap?.respCode == '101') {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        print("Invalid number*******");
      } else {
        errorMessage.value = model.responseMap?.respDesc ?? '';
        print("Invalid number*******");
      }
    } else {
      errorMessage.value = pleaseEnterValidMsisdnStr;
    }
  }

  _generateOtp(String msisdn) async {
    isVerifying.value = true;
    GenerateOtpModel result = await LoginVm().generateOtp(msisdn);

    if (result.statusCode == "SC0000") {
      //isMsisdnVarified.value = true;
    } else {
      errorMessage.value = result.message;
      isMsisdnVarified.value = false;
      isVerifying.value = false;
    }
  }

  Future<void> getSecurityToken(String msisdn) async {
    var map = await GetSecurityVM().token();
    if (map != null) {
      GetSecurityTokenModel model = GetSecurityTokenModel.fromJson(map);
      StoreManager().securityCounter = model.responseMap.securityCounter;
      securityCounter = model.responseMap.securityCounter;
      bool isRegistered =
          await NewRegistrartionVm().register(msisdn, securityCounter);
      isVerifying.value = false;
      if (isRegistered) {
        await _generateOtp(msisdn);
        return;
      } else {
        errorMessage.value = someThingWentWrongStr;
        isVerifying.value = false;
      }
      print("NewRegistrartionVm status $isRegistered");
      return;
    }
    isVerifying.value = false;
    return;
  }

  getTunePrice() async {
    await GetTunePrice().api(msisdn.value, info?.toneId ?? '');
  }

  updateOtp(String value) {
    otp.value = value;
    errorMessage.value = '';
  }

  updateMsisdn(String value) {
    msisdn.value = value;
    errorMessage.value = '';
  }

  verifyingOtp() async {
    isVerifyingOtp.value = true;
    if (otp.value.length == StoreManager().otpLength) {
      await Future.delayed(const Duration(seconds: 1));
      isVerifyingOtp.value = false;
      return;
    }
    errorMessage.value = pleaseEnterAValidOtpStr;
  }
}
