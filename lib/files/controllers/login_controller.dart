import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isVerifying = false.obs;
  RxBool isMsisdnVarified = false.obs;
  RxString msisdn = ''.obs;
  RxString otp = ''.obs;
  varifyMsisdnButtonAction() async {
    print("varifying Otp");
    isVerifying.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isMsisdnVarified.value = true;
    isVerifying.value = false;
    print("varified Otp");
  }

  resetValue() async {
    isVerifying.value = false;
    isMsisdnVarified.value = false;
    otp.value = '';
  }

  verifyOtpButtonAction() async {
    print("Verify otp tapped");
  }
}
