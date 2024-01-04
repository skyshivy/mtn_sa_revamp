import 'package:get/get.dart';

class SetTuneController extends GetxController {
  RxInt selectedDay = 0.obs;
  RxInt selectedHour = 0.obs;
  RxInt selectedMinute = 0.obs;
  RxBool isSetting = false.obs;
  RxString errorMessage = ''.obs;

  setStatusTune() async {
    isSetting.value = true;
    print("set status tune");
    print("selected day =$selectedDay");
    print("selected hour =$selectedHour");
    print("selected minutes =$selectedMinute");
    await Future.delayed(Duration(seconds: 4));
    isSetting.value = false;
  }
}
