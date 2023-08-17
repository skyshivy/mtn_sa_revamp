import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
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
  DateTime? _fromTD;
  DateTime? _toTD;
  String _fromTimeStr = '';
  String _toTimeStr = '';
  String tuneImage = '';
  String tuneArtist = '';
  String _dedicatedMsisdn = '';
  String packName = '';
  ToWhomAction _toWhome = ToWhomAction.allCaller;
  SelectTimeType _timeType = SelectTimeType.fullday;
  RepeatYearlyViewAction _repeatYearlyViewAction = RepeatYearlyViewAction.none;
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
  fromTimeStr(String fromTime) {
    _fromTimeStr = fromTime;
  }

  toTimeStr(String toTime) {
    _toTimeStr = toTime;
  }

  updateDedictedUser(String text) {
    _dedicatedMsisdn = text;
  }

  updateToWhom(ToWhomAction toWhomAction) {
    _toWhome = toWhomAction;
  }

  updateRepate(RepeatYearlyViewAction action) {
    _repeatYearlyViewAction = action;
  }

  updateTimeType(SelectTimeType type) {
    _timeType = type;
  }

  updateMsisdn(String msisdn) {
    this.msisdn.value = msisdn;
  }

  setTune() {
    _checkToWhom(_toWhome);
  }

  _checkToWhom(ToWhomAction selection) {
    switch (selection) {
      case ToWhomAction.allCaller:
        _setTuneForAllCaller();
        break;
      case ToWhomAction.specificCaller:
        _setTuneForSpecificCaller();
        break;
      default:
    }
  }

  _setTuneForAllCaller() async {
    if (SelectTimeType.fullday == _timeType) {
      print("_allCallerFullDay");
      //await _allCallerFullDay();
    } else if (SelectTimeType.time == _timeType) {
      print("_allCallerTimeBase");
      //await _allCallerTimeBase();
    } else {
      if (RepeatYearlyViewAction.none == _repeatYearlyViewAction) {
        print("_allCallerDateBaseNone");
        //_allCallerDateBaseNone();
      } else if (RepeatYearlyViewAction.monthly == _repeatYearlyViewAction) {
        print("_allCallerDateBaseMonthly");
        //_allCallerDateBaseMonthly();
      } else {
        print("_allCallerDateBaseYearly");
        //_allCallerDateBaseYearly();
      }
    }
  }

  _setTuneForSpecificCaller() async {
    if (SelectTimeType.fullday == _timeType) {
      print("_dedicatedFullDay");
      //_dedicatedFullDay();
    } else if (SelectTimeType.time == _timeType) {
      print("_dedicatedTimeBase");
      //_dedicatedTimeBase();
    } else {
      if (RepeatYearlyViewAction.none == _repeatYearlyViewAction) {
        print("_dedicatedDateBaseNone");
        //_dedicatedDateBaseNone();
      } else if (RepeatYearlyViewAction.monthly == _repeatYearlyViewAction) {
        print("_dedicatedDateBaseMonthly");
        //_dedicatedDateBaseMonthly();
      } else {
        print("_dedicatedDateBaseYearly");
        //_dedicatedDateBaseYearly();
      }
    }
  }

  _result(Map<String, dynamic>? map) {
    if (map != null) {
      SetToneModel model = SetToneModel.fromJson(map);
      if (model.statusCode == "SC0000") {
        return;
      } else {
        showSnackBar(message: model.message ?? '');
        return;
      }
    }
    showSnackBar(message: someThingWentWrongStr);
  }

  _allCallerFullDay() async {
    var map = await TuneSettingAllCallerVM()
        .setAllCallerFullDay(tuneId, selectedDays);
    _result(map);
  }

  _allCallerTimeBase() async {
    var map = await TuneSettingAllCallerVM()
        .allCallerTimeBase(tuneId, selectedDays, _fromTimeStr, endTimeStr);
    _result(map);
  }

  _allCallerDateBaseNone() async {
    var map = await TuneSettingAllCallerVM()
        .allCallerNone(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _allCallerDateBaseMonthly() async {
    var map = await TuneSettingAllCallerVM()
        .allCallerMonthly(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _allCallerDateBaseYearly() async {
    var map = await TuneSettingAllCallerVM()
        .allDayYearly(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _dedicatedFullDay() async {
    var map = await TuneSettingDedicatedVM()
        .dedicatedFullday(tuneId, _dedicatedMsisdn, packName, selectedDays);
    _result(map);
  }

  _dedicatedTimeBase() async {
    var map = await TuneSettingDedicatedVM().dedicatedTimeBase(tuneId,
        _dedicatedMsisdn, packName, selectedDays, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseNone() async {
    var map = await TuneSettingDedicatedVM().dedicatedNone(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseMonthly() async {
    var map = await TuneSettingDedicatedVM().dedicatedMonthly(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseYearly() async {
    var map = await TuneSettingDedicatedVM().dedicatedYearly(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }
}
