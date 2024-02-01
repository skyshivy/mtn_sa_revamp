import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/model/set_tune_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/model/day_model.dart';
import 'package:mtn_sa_revamp/files/utility/style.dart';
import 'package:mtn_sa_revamp/files/view_model/add_to_suffle_api_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/get_pack_status_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/tune_setting_all_caller_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/tune_setting_dedicated_vm.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class TuneSettingController extends GetxController {
  MyTuneController tuneCont = Get.find();
  RxInt callerType = 0.obs;
  RxInt repeatYear = 0.obs;
  RxString msisdn = ''.obs;
  RxBool isLoading = false.obs;
  String tuneName = '';
  String tuneId = '';
  DateTime? _fromTD;
  DateTime? _toTD;
  String _fromTimeStr = '';
  String _toTimeStr = '';
  String tuneImage = '';
  String tuneArtist = '';
  RxBool isCrbt = true.obs;
  String _dedicatedMsisdn = '';
  String packName = '';
  late BuildContext context;
  RxBool isTimeAndDate = false.obs;
  RxBool isTime = false.obs;
  RxString timeTypeBtm = fullDay24HourStr.obs;
  ToWhomAction _toWhome = ToWhomAction.allCaller;
  SelectTimeType timeType = SelectTimeType.fullday;
  RepeatYearlyViewAction _repeatYearlyViewAction = RepeatYearlyViewAction.none;
  String selectedDays = '';
  RxString error = ''.obs;

  List<DayModel> daysList = [
    DayModel(sunStr.tr),
    DayModel(monStr.tr),
    DayModel(tueStr.tr),
    DayModel(wedStr.tr),
    DayModel(thusStr.tr),
    DayModel(friStr.tr),
    DayModel(satStr.tr)
  ];
  List<DayModel> sortDaysList = [
    DayModel(sStr.tr),
    DayModel(mStr.tr),
    DayModel(tStr.tr),
    DayModel(wStr.tr),
    DayModel(tStr.tr),
    DayModel(fStr.tr),
    DayModel(saStr.tr)
  ];
  openCalenderView(BuildContext context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: blue,
        dayTextStyle: calenderDateStyle(),
        weekdayLabelTextStyle: calenderWeekDayStyle(),
        yearTextStyle: calenderYearStyle(),
        selectedYearTextStyle: calenderYearStyle(),
        controlsTextStyle: calenderYearStyle(),
      ),
      dialogSize: const Size(300, 350),
      borderRadius: BorderRadius.circular(15),
    );
    printCustom("Seelcted date is ${results?.length}");
  }

  getPackName() async {
    PackStatusModel packStatusModel =
        await getPackStatusApiCall(StoreManager().msisdn);
    if (packStatusModel.statusCode == 'SC0000') {
      packName = packStatusModel.responseMap?.packStatusDetails?.packName ?? '';
    }
  }

  updateSelectedDay(String text) {
    selectedDays = text;
    printCustom("selected id = $selectedDays");
  }

  fromTimeStr(String fromTime) {
    _fromTimeStr = fromTime;
  }

  toTimeStr(String toTime) {
    _toTimeStr = toTime;
  }

  updateRepeatYear(int index) {
    repeatYear.value = index;
    if (index == 0) {
      _repeatYearlyViewAction = RepeatYearlyViewAction.none;
      timeType = SelectTimeType.fullday;
    } else if (index == 1) {
      _repeatYearlyViewAction = RepeatYearlyViewAction.monthly;
      timeType = SelectTimeType.time;
    } else if (index == 2) {
      _repeatYearlyViewAction = RepeatYearlyViewAction.yearly;
      timeType = SelectTimeType.timeDate;
    }
  }

  updateDedictedUser(String text) {
    _dedicatedMsisdn = text;
    msisdn.value = text;
  }

  updateToWhom(ToWhomAction toWhomAction) {
    _toWhome = toWhomAction;
    printCustom("TO whom $_toWhome");
  }

  updateTimeType(SelectTimeType type) {
    timeType = type;
    isTimeAndDate.value = (timeType == SelectTimeType.timeDate);
    printCustom("selected time type is $type");
  }

  updatebPartyMsisdn(String msisdn) {
    this.msisdn.value = msisdn;
  }

  setTune(BuildContext context) {
    this.context = context;
    _checkToWhom(_toWhome);
  }

  _checkToWhom(ToWhomAction selection) {
    switch (selection) {
      case ToWhomAction.allCaller:
        _setTuneForAllCaller();
        break;
      case ToWhomAction.specificCaller:
        if (msisdn.isEmpty ||
            (msisdn.value.length < StoreManager().msisdnLength)) {
          showSnackBar(message: pleaseEnterValidMsisdnStr.tr);
          return;
        }
        _setTuneForSpecificCaller();
        break;
      case ToWhomAction.addToSuffle:
        printCustom("ToWhomAction.addToSuffle");
        _addToSuffleApiCall();
        //_setTuneForCallergroup();
        break;
      default:
    }
  }

  _addToSuffleApiCall() async {
    isLoading.value = true;
    Map<String, dynamic>? map = await addToSuffleApi(tuneId, isCrbt.value);
    _result(map);
    printCustom("object");
  }

  _setTuneForAllCaller() async {
    if (isTimeAndDate.value) {
      if (RepeatYearlyViewAction.none == _repeatYearlyViewAction) {
        printCustom("_allCallerDateBaseNone");
        _allCallerDateBaseNone();
      } else if (RepeatYearlyViewAction.monthly == _repeatYearlyViewAction) {
        printCustom("_allCallerDateBaseMonthly");
        _allCallerDateBaseMonthly();
      } else if (RepeatYearlyViewAction.yearly == _repeatYearlyViewAction) {
        printCustom("_allCallerDateBaseYearly");
        _allCallerDateBaseYearly();
      }
    } else {
      if (SelectTimeType.fullday == timeType) {
        printCustom("_allCallerFullDay");
        await _allCallerFullDay();
      } else if (SelectTimeType.time == timeType) {
        printCustom("_allCallerTimeBase");
        await _allCallerTimeBase();
      }
    }
  }

  _setTuneForSpecificCaller() async {
    if (isTimeAndDate.value) {
      if (RepeatYearlyViewAction.none == _repeatYearlyViewAction) {
        printCustom("_dedicatedDateBaseNone");
        _dedicatedDateBaseNone();
      } else if (RepeatYearlyViewAction.monthly == _repeatYearlyViewAction) {
        printCustom("_dedicatedDateBaseMonthly");
        _dedicatedDateBaseMonthly();
      } else {
        printCustom("_dedicatedDateBaseYearly");
        _dedicatedDateBaseYearly();
      }
    } else {
      if (SelectTimeType.fullday == timeType) {
        printCustom("_dedicatedFullDay");
        _dedicatedFullDay();
      } else if (SelectTimeType.time == timeType) {
        printCustom("_dedicatedTimeBase");
        _dedicatedTimeBase();
      }
    }
  }

  _result(Map<String, dynamic>? map) {
    isLoading.value = false;
    if (map != null) {
      SetToneModel model = SetToneModel.fromJson(map);
      if (model.statusCode == "SC0000") {
        context.go(myTuneGoRoute);
        tuneCont.getMyPlayingList();
        showSnackBar(message: model.message ?? '');
        return;
      } else {
        //context.go(myTuneGoRoute);
        showSnackBar(message: model.message ?? '');
        return;
      }
    }
    showSnackBar(message: someThingWentWrongStr.tr);
  }

  _allCallerFullDay() async {
    isLoading.value = true;
    var map = await TuneSettingAllCallerVM()
        .setAllCallerFullDay(tuneId, selectedDays);
    _result(map);
  }

  _allCallerTimeBase() async {
    isLoading.value = true;
    var map = await TuneSettingAllCallerVM()
        .allCallerTimeBase(tuneId, selectedDays, _fromTimeStr, endTimeStr.tr);
    _result(map);
  }

  _allCallerDateBaseNone() async {
    isLoading.value = true;
    var map = await TuneSettingAllCallerVM()
        .allCallerNone(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _allCallerDateBaseMonthly() async {
    isLoading.value = true;
    var map = await TuneSettingAllCallerVM()
        .allCallerMonthly(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _allCallerDateBaseYearly() async {
    isLoading.value = true;
    var map = await TuneSettingAllCallerVM()
        .allDayYearly(tuneId, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  _dedicatedFullDay() async {
    isLoading.value = true;
    var map = await TuneSettingDedicatedVM()
        .dedicatedFullday(tuneId, _dedicatedMsisdn, packName, selectedDays);
    _result(map);
  }

  _dedicatedTimeBase() async {
    isLoading.value = true;
    var map = await TuneSettingDedicatedVM().dedicatedTimeBase(tuneId,
        _dedicatedMsisdn, packName, selectedDays, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseNone() async {
    isLoading.value = true;
    var map = await TuneSettingDedicatedVM().dedicatedNone(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseMonthly() async {
    isLoading.value = true;
    var map = await TuneSettingDedicatedVM().dedicatedMonthly(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }

  void _dedicatedDateBaseYearly() async {
    isLoading.value = true;
    var map = await TuneSettingDedicatedVM().dedicatedYearly(tuneId,
        _dedicatedMsisdn, packName, _fromTD, _toTD, _fromTimeStr, _toTimeStr);
    _result(map);
  }
}
