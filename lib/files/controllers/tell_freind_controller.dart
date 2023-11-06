import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';

class TellFriendController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isVerifing = false.obs;
  RxString bPartyMsisdn = ''.obs;
  RxString errorMessage = ''.obs;
  String tuneCharge = '';

  @override
  void onInit() {
    getTuneCharge();
    super.onInit();
  }

  getTuneCharge() {
    tuneCharge = StoreManager()
            .appSetting
            .responseMap
            ?.settings
            ?.others
            ?.tonePrice
            ?.attribute ??
        '';
  }

  updateMsisdn(String value) {
    bPartyMsisdn.value = value;
    errorMessage.value = '';
  }

  confirmButtonAction() {
    if (bPartyMsisdn.value.length < StoreManager().msisdnLength) {
      errorMessage.value = enterValidMsisdnStr;
      return;
    }
    _validateMsisdn();
  }

  _validateMsisdn() async {
    errorMessage.value = '';
    isVerifing.value = true;
    String stringData = await LoginVm().subscribeMsisdn(bPartyMsisdn.value);
    Map<String, dynamic> valueMap = json.decode(stringData);
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    print("Status code is ${model.statusCode}");
    if (model.responseMap?.respCode == "SC0000" ||
        model.responseMap?.respCode == '100') {
    } else {
      errorMessage.value = model.message ?? someThingWentWrongStr;
    }

    isVerifing.value = false;
    printCustom("confirm button tapped Tapped");
  }
}
