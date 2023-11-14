import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/send_gift_model.dart';
import 'package:mtn_sa_revamp/files/model/subscriber_valid_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_price_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/view_model/get_tune_price_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/login_vm.dart';
import 'package:mtn_sa_revamp/files/view_model/send_gift_vm.dart';

class GiftTuneController extends GetxController {
  RxBool isSendDone = false.obs;
  RxBool isVerifing = false.obs;
  RxString bPartyMsisdn = ''.obs;
  RxString errorMessage = ''.obs;
  String tuneCharge = '';
  String packName = '';
  late TuneInfo info;
  @override
  void onInit() {
    getTuneCharge();
    super.onInit();
  }

  getTuneCharge() {
    tuneCharge = StoreManager()
            .appSetting
            ?.responseMap
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

  confirmButtonAction(TuneInfo info) {
    this.info = info;
    print("MSIDN is ${StoreManager().msisdn}");
    if (bPartyMsisdn.value.length < StoreManager().msisdnLength) {
      errorMessage.value = enterValidMsisdnStr;
      return;
    }
    if (bPartyMsisdn.value == StoreManager().msisdn) {
      errorMessage.value = bothMsisdnCanBeSameStr;
      return;
    }
    _validateMsisdn();
  }

  _validateMsisdn() async {
    errorMessage.value = '';
    isVerifing.value = true;
    isSendDone.value = false;
    String stringData = await LoginVm().subscribeMsisdn(bPartyMsisdn.value);
    Map<String, dynamic> valueMap = json.decode(stringData);
    SubscriberValidationModel model =
        SubscriberValidationModel.fromJson(valueMap);
    print("Status code is ${model.statusCode}");
    if (model.responseMap?.respCode == "SC0000" ||
        model.responseMap?.respCode == '100') {
      await getTunePrice();
      return;
    } else {
      errorMessage.value = model.message ?? someThingWentWrongStr;
      isVerifing.value = false;
    }

    isVerifing.value = false;
    printCustom("confirm button tapped Tapped");
  }

  getTunePrice() async {
    Map<String, dynamic>? map = await GetTunePrice().api(
        StoreManager().msisdn, info.toneId ?? '', '2',
        bParty: bPartyMsisdn.value);

    if (map != null) {
      TonePriceModel model = TonePriceModel.fromJson(map);
      packName = model.responseMap?.responseDetails?.first.packName ?? '';
      if (model.statusCode == 'SC0000') {
        Map<String, dynamic>? map = await SendGiftVM().send(bPartyMsisdn.value,
            info.toneId ?? '', packName, info.toneName ?? '');

        if (map != null) {
          SendGiftModel model = SendGiftModel.fromJson(map);
          printCustom("Send gift resp is $model");
          isVerifing.value = false;

          if (model.statusCode == 'SC0000') {
            errorMessage.value = model.message ?? '';
            isSendDone.value = true;
          } else {
            errorMessage.value = model.responseMap?.responseMessage ?? '';
          }
        }
      } else {
        errorMessage.value = model.message ?? '';
        isVerifing.value = false;
      }
    }
  }
}
