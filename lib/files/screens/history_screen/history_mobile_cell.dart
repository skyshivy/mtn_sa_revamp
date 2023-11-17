import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/history_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/history_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class HistoryMobileCell extends StatelessWidget {
  final HistoryController hCont = Get.find();
  final TransactionDetailsList info;
  HistoryMobileCell({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              topSecion(),
              const SizedBox(height: 20),
              bottomSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget topSecion() {
    String date = "${info.subscriptionDate?.day}"
        "/"
        "${info.subscriptionDate?.month}"
        "/"
        "${info.subscriptionDate?.year}";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topRowTuneNameSection(),
        CustomText(
          title: info.callCharge ?? '',
          fontName: FontName.bold,
        ),
      ],
    );
  }

  Row topRowTuneNameSection() {
    String date = "${info.subscriptionDate?.day}"
        "/"
        "${info.subscriptionDate?.month}"
        "/"
        "${info.subscriptionDate?.year}";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomText(
            title: info.englishToneName ?? '',
            fontName: FontName.bold,
          ),
        ),
        CustomText(title: date),
      ],
    );
  }

  Widget bottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        bottomTitleSubTitle(
          transactionTypeStr,
          info.transactionType ?? '',
          txtColor: ((info.transactionType ?? '') == "Activated")
              ? Colors.green
              : red,
        ),
        bottomTitleSubTitle(channelStr, info.channel ?? '',
            crossAxisAlignment: CrossAxisAlignment.end),
      ],
    );
  }

  Widget bottomTitleSubTitle(String title, String subTitle,
      {Color txtColor = black,
      CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomText(title: title),
        CustomText(
          title: subTitle,
          textColor: txtColor,
          fontName: FontName.bold,
        ),
      ],
    );
  }
}
