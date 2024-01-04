import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/subscription_view.dart';
import 'package:mtn_sa_revamp/files/model/set_status_tune_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_price_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/view_model/get_tune_price_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/set_status_tune_vm.dart';

class SetTuneController extends GetxController {
  RxInt selectedDay = 0.obs;
  RxInt selectedHour = 0.obs;
  RxInt selectedMinute = 0.obs;
  RxBool isSetting = false.obs;
  RxString errorMessage = ''.obs;
  Function()? onSuccess;
  String packName = '';
  SetTuneController();
  setStatusTune(TuneInfo? info) async {
    errorMessage.value = '';
    isSetting.value = true;
    getTunePrice(info ?? TuneInfo());
  }

  getTunePrice(TuneInfo info) async {
    Map<String, dynamic>? map =
        await GetTunePrice().api(StoreManager().msisdn, info.toneId ?? '');

    if (map != null) {
      TonePriceModel model = TonePriceModel.fromJson(map);
      if (model.statusCode == 'SC0000') {
        ResponseDetail? responseDetail =
            model.responseMap?.responseDetails?.first;
        packName = responseDetail?.packName ?? '';
        String status = responseDetail?.subscriberStatus ?? '';
        if ((status == 'NA') || (status == 'D') || (status == 'd')) {
          _selectSubscriptionPlan(info);
        } else {
          await _setDateAndMakeApiCall(info.toneId ?? '');
        }
      } else {
        errorMessage.value = model.message ?? someThingWentWrongStr.tr;
        isSetting.value = false;
      }
    } else {
      errorMessage.value = someThingWentWrongStr.tr;
    }
  }

  _selectSubscriptionPlan(TuneInfo? info) {
    Get.dialog(SubscriptionView(
      info: info ?? TuneInfo(),
      onSelect: (p0, cotext) {
        packName = p0;
        _setDateAndMakeApiCall(info?.toneId ?? '');
        onSuccess = () async {
          print("On fail");
          Navigator.of(cotext).pop();
          await Future.delayed(Duration(milliseconds: 200));
          Get.dialog(Center(
            child: CustomAlertView(title: errorMessage.value),
          ));
        };

        print("Selected pack name = $p0");
      },
    ));
  }

  Future<void> _setDateAndMakeApiCall(String tuneId) async {
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

    isSetting.value = false;
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
