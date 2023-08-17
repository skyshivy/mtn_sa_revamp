import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/set_tune_model.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/model/day_model.dart';
import 'package:mtn_sa_revamp/files/view_model/tune_setting_all_caller_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/tune_setting_dedicated_vm.dart';

class TuneSettingController extends GetxController {
  RxInt callerType = 0.obs;
  RxString msisdn = ''.obs;
  String tuneName = '';
  String tuneId = '';
  DateTime? fromTD;
  DateTime? toTD;
  String fromTimeStr = '';
  String toTimeStr = '';
  String tuneImage = '';
  String tuneArtist = '';
  String dedicatedMsisdn = '';
  String packName = '';
  String selectedDays = '';
  RxString error = ''.obs;

  List<DayModel> daysList = [
    DayModel(sunStr),
    DayModel(monStr),
    DayModel(tueStr),
    DayModel(wedStr),
    DayModel(thusStr),
    DayModel(friStr),
    DayModel(satStr)
  ];

  updateMsisdn(String msisdn) {
    this.msisdn.value = msisdn;
  }

  result(Map<String, dynamic> map) {
    SetToneModel model = SetToneModel.fromJson(map);
    if (model.statusCode == "SC0000") {
    } else {
      showSnackBar(message: model.message ?? '');
    }
  }

  allCallerDateBaseNone() async {
    var map = await TuneSettingAllCallerVM()
        .allCallerNone(tuneId, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("allCallerDateBaseNone");
  }

  allCallerDateBaseMonthly() async {
    var map = await TuneSettingAllCallerVM()
        .allCallerMonthly(tuneId, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
  }

  allCallerDateBaseYearly() async {
    var map = await TuneSettingAllCallerVM()
        .allDayYearly(tuneId, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("allCallerDateBaseYearly");
  }

  dedicatedFullDay() async {
    var map = await TuneSettingDedicatedVM()
        .dedicatedFullday(tuneId, dedicatedMsisdn, packName, selectedDays);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("dedicatedFullDay");
  }

  dedicatedTimeBase() async {
    var map = await TuneSettingDedicatedVM().dedicatedTimeBase(tuneId,
        dedicatedMsisdn, packName, selectedDays, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("dedicatedTimeBase");
  }

  void dedicatedDateBaseNone() async {
    var map = await TuneSettingDedicatedVM().dedicatedNone(tuneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("dedicatedDateBaseNone");
  }

  void dedicatedDateBaseMonthly() async {
    var map = await TuneSettingDedicatedVM().dedicatedMonthly(tuneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("dedicatedDateBaseMonthly");
  }

  void dedicatedDateBaseYearly() async {
    var map = await TuneSettingDedicatedVM().dedicatedYearly(tuneId,
        dedicatedMsisdn, packName, fromTD, toTD, fromTimeStr, toTimeStr);
    if (map != null) {
      result(map);
      return;
    }
    showSnackBar(message: someThingWentWrongStr);
    print("dedicatedDateBaseYearly");
  }
}
