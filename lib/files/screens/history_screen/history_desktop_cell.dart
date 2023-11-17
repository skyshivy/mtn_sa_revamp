import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/history_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class HistoryDesktopCell extends StatelessWidget {
  final TransactionDetailsList info;

  const HistoryDesktopCell({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            children: [
              TableRow(
                children: [
                  tuneNameAndPriceWidget(),
                  transactionTypeWidget(),
                  channelWidget(),
                  dateWidget()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tuneNameAndPriceWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: info.englishToneName ?? '',
          fontName: FontName.bold,
          fontSize: 14,
        ),
        const SizedBox(height: 6),
        CustomText(
          title: info.callCharge ?? '',
          fontName: FontName.medium,
          textColor: subTitleColor,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget dateWidget() {
    final formatter = NumberFormat('00');
    String date = "${formatter.format(info.subscriptionDate?.day)}"
        "/"
        "${formatter.format(info.subscriptionDate?.month)}"
        "/"
        "${info.subscriptionDate?.year}";
    String time = "${formatter.format(info.subscriptionDate?.hour)} :"
        "${formatter.format(info.subscriptionDate?.minute)}";
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          title: date,
          fontName: FontName.bold,
          fontSize: 14,
        ),
        CustomText(
          title: time,
          fontName: FontName.bold,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget transactionTypeWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: transactionTypeStr,
          fontName: FontName.bold,
          fontSize: 14,
        ),
        const SizedBox(height: 6),
        CustomText(
          title: info.transactionType ?? '',
          fontName: FontName.medium,
          textColor: ((info.transactionType ?? '') == "Activated"
              ? Colors.green
              : red),
          fontSize: 14,
        ),
      ],
    );
  }

  Widget channelWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          title: channelStr,
          fontName: FontName.bold,
          fontSize: 14,
        ),
        const SizedBox(height: 6),
        CustomText(
          title: info.channel ?? '',
          fontName: FontName.medium,
          textColor: subTitleColor,
          fontSize: 14,
        ),
      ],
    );
  }
}
