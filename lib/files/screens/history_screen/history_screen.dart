import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/history_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/history_screen/history_desktop_cell.dart';
import 'package:mtn_sa_revamp/files/screens/history_screen/history_mobile_cell.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late HistoryController hCont;
  @override
  void initState() {
    hCont = Get.find();
    hCont.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Center(child: ResponsiveBuilder(
        builder: (context, si) {
          return Obx(
            () {
              return hCont.isLoading.value
                  ? loadingIndicator()
                  : hCont.transactions.isEmpty
                      ? emptyHistory()
                      : listView(si);
            },
          );
        },
      )),
    );
  }

  Widget emptyHistory() {
    return Center(
        child: CustomText(
      title: noTransactionFoundStr.tr,
      fontName: FontName.bold,
      fontSize: 20,
    ));
  }

  Widget listView(SizingInformation si) {
    return Column(
      children: [
        CustomTopHeaderView(title: historyStr.tr),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: hCont.transactions.length,
            itemBuilder: (context, index) {
              return listCell(si, index);
            },
          ),
        ),
      ],
    );
  }

  Widget listCell(SizingInformation si, int index) {
    return si.isMobile
        ? HistoryMobileCell(info: hCont.transactions[index])
        : HistoryDesktopCell(
            info: hCont.transactions[index],
          );
  }
}
