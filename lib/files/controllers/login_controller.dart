import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/generate_otp_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';

class LoginController extends GetxController {
  RxBool isVerifying = false.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString msisdn = ''.obs;
  RxString errorMessage = ''.obs;
  RxString otp = ''.obs;
  varifyMsisdnButtonAction() async {
    errorMessage.value = '';
    int len = StoreManager().msisdnLength;
    if (msisdn.value.length < (len)) {
      errorMessage.value = enterValidMsisdnStr;
      return;
    }
    print("varifying Msisdn");
    isVerifying.value = true;
    await _validationMsisdn();
    isVerifying.value = false;
    print("varified Msisdn");
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
    print("Verify otp tapped");
    return await _confirmOtpApi();
  }

  Future<String> _validationMsisdn() async {
    String stringData = await LoginVm().subscribeMsisdn(msisdn.value);
    Map<String, dynamic> valueMap = json.decode(stringData);
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    if (model.responseMap?.respCode == 'SC0000') {
      await _generateOtp();
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
    return "";
  }

  Future<void> _generateOtp() async {
    GenerateOtpModel result = await LoginVm().generateOtp(msisdn.value);
    isMsisdnVarified.value = true;
    print("Generate otp api call here");
  }

  Future<bool> _confirmOtpApi() async {
    print("Resu =Sky========");
    isVerifying.value = true;
    ConfirmOtpModel model = await LoginVm().confirmOtp(msisdn.value, otp.value);
    isVerifying.value = false;
    if (model.statusCode == "SC0000") {
      return true;
    } else {
      errorMessage.value = model.message ?? '';
      return false;
    }
  }
}
