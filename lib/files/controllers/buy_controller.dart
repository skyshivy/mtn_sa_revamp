import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_opt_view.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/get_tune_price_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';

class BuyController extends GetxController {
  AppController appController = Get.find();
  RxBool isVerifying = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString otp = ''.obs;
  RxString msisdn = '9923964719'.obs;
  late TuneInfo? info;
  Future<void> msisdnValidation(TuneInfo? inf) async {
    info = inf;
    if (msisdn.value.length == StoreManager().msisdnLength) {
      isVerifying.value = true;
      String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
      Map<String, dynamic> valueMap = json.decode(stringData);
      isVerifying.value = false;
      SubscriberValidationModel model =
          SubscriberValidationModel.fromJson(valueMap);
      if (model.responseMap?.respCode == 'SC0000') {
        await _generateOtp(msisdn.value);
        print("Existing user******");
      } else if (model.responseMap?.respCode == '100') {
        isMsisdnVarified.value = true;
        print("New User*******");
        getSecurityToken(msisdn.value);
        //getTunePrice();
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
    isVerifying.value = false;
    if (result.statusCode == "SC0000") {
      //isMsisdnVarified.value = true;
    } else {
      errorMessage.value = result.message;
      isMsisdnVarified.value = false;
    }
  }

  getSecurityToken(String msisdn) async {}
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
    if (otp.value.length == StoreManager().otpLength) {
      isVerifying.value = true;
      await Future.delayed(const Duration(seconds: 1));
      isVerifying.value = false;
      return;
    }
    errorMessage.value = pleaseEnterAValidOtpStr;
  }
}
