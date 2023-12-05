import 'dart:async';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class OtpTimerController extends GetxController {
  Timer? _timer;
  int _start = resendOtpDuration;
  RxString timeLeft = ''.obs;
  RxBool isRunning = false.obs;
  RxBool isLoading = false.obs;
  LoginController logCont = Get.find();
  @override
  void onInit() {
    super.onInit();
    print("OtpTimerController initialized");
    initTimer();
  }

  @override
  void onClose() {
    cancelTimer();
    print("OtpTimerController disposed");
    super.onClose();
  }

  cancelTimer() {
    _timer?.cancel();
  }

  startTimer() async {
    if (isRunning.value) {
      return;
    }
    _start = resendOtpDuration;
    isLoading.value = true;
    await logCont.generateOtp();
    isLoading.value = false;
    initTimer();
  }

  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }

  initTimer() {
    timeLeft.value = _formatDuration(_start);
    print("start time ${_start}===== ${timeLeft.value}");

    isRunning.value = true;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          isRunning.value = false;
          print("start time ${_start}");
          timeLeft.value = '';
          isRunning.value = false;
          cancelTimer();
        } else {
          _start--;

          timeLeft.value = _formatDuration(_start);
          print("start time ${_start}===== ${timeLeft.value}");
        }
      },
    );
  }
}
