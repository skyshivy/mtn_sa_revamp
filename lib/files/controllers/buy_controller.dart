import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/screens/login_screen/login_screen.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_opt_view.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';

class BuyController extends GetxController {
  RxBool isVerifying = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString otp = ''.obs;
  RxString msisdn = ''.obs;
  Future<void> msisdnValidation() async {
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
        print("New user*****");
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
