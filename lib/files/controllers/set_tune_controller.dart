import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/set_status_tune_model.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/view_model/set_status_tune_vm.dart';

class SetTuneController extends GetxController {
  RxInt selectedDay = 0.obs;
  RxInt selectedHour = 0.obs;
  RxInt selectedMinute = 0.obs;
  RxBool isSetting = false.obs;
  RxString errorMessage = ''.obs;
  Function()? onSuccess;

  SetTuneController();
  setStatusTune(String packName, String tuneId) async {
    errorMessage.value = '';
    isSetting.value = true;
    await _setDateAndMakeApiCall(packName, tuneId);
    isSetting.value = false;
  }

  Future<void> _setDateAndMakeApiCall(String packName, String tuneId) async {
    var now = DateTime.now();

    var sD = DateTime(now.year, now.month, now.day);
    var startTime = "${now.hour}:${now.minute}:${now.second}";
    var startDate = "${sD.year}-${sD.month}-${sD.day}";
    DateTime eD = now.add(Duration(
        days: selectedDay.value,
        hours: selectedHour.value,
        minutes: selectedMinute.value));

    var endDate = "${eD.year}-${eD.month}-${eD.day}";
    var endTime = "${eD.hour}:${eD.minute}:${eD.second}";
    print("Start date $startDate");
    print("Start time $startTime");

    print("end date $endDate");
    print("end time $endTime");

    SetStatusTuneModel model = await setStatusTuneVm(
        packName, tuneId, startDate, endDate, startTime, endTime);
    if (model.statusCode == 'SC0000') {
      errorMessage.value = model.message ?? someThingWentWrongStr.tr;
      if (onSuccess != null) {
        onSuccess!();
      }
    } else {
      errorMessage.value = model.message ?? someThingWentWrongStr.tr;
    }

    return;
  }
}
