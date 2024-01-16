import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_rrbt_tune_list_view/my_rrbt_tune_list_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_header_widgets/my_tune_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/myTune_list_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/my_tune_playing_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class MyTuneScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTuneScreenState();
  }
}

class _MyTuneScreenState extends State<MyTuneScreen> {
  late MyTuneController controller;
  @override
  void initState() {
    printCustom("initState");
    controller = Get.find();
    controller.getPlayingTuneList();
    super.initState();
  }

  @override
  void dispose() {
    printCustom("Disposed");
    Get.delete<MyTuneController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: ResponsiveBuilder(
        builder: (context, si) {
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyTuneHeaderView(),
              const SizedBox(height: 15),
              sectionTabContainer(si),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 4 : 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myPlayintTuneSection(),
                    // SizedBox(height: si.isMobile ? 25 : 80),
                    myRrbtSection(),
                    myTuneListSection(),
                    SizedBox(height: si.isMobile ? 20 : 60),
                  ],
                ),
              ),
            ],
          ));
        },
      ),
    );
  }

  Obx myTuneListSection() {
    return Obx(() {
      return Visibility(
          visible: controller.selectedSection.value == 2,
          child: controller.isLoadingTune.value
              ? loadInd()
              : checkMyTuneListEmpty());
    });
  }

  Obx myRrbtSection() {
    return Obx(() {
      return Visibility(
        visible: controller.selectedSection.value == 1,
        child: MyRrbtTuneListView(),
      );
    });
  }

  Obx myPlayintTuneSection() {
    return Obx(() {
      return Visibility(
          visible: controller.selectedSection.value == 0,
          child: controller.isLoadingPlaying.value
              ? loadInd()
              : checkMyPlayingTuneEmpty());
    });
  }

  Padding sectionTabContainer(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 4 : 20),
      child: Container(
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                tabSection(playingTuneStr, 0, si),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: tabSection(myRrbtTunesStr, 1, si),
                ),
                tabSection(myTuneStr, 2, si),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabSection(String title, int index, SizingInformation si) {
    return Obx(() {
      return CustomButton(
        onTap: () {
          controller.selectedSection.value = index;
        },
        titlePadding: const EdgeInsets.symmetric(horizontal: 10),
        height: 45,
        fontSize: si.isMobile ? 12 : 14,
        fontName: FontName.bold,
        color: (controller.selectedSection.value == index) ? blue : greyLight,
        textColor: (controller.selectedSection.value == index) ? white : black,
        title: title,
        radius: 4,
      );
    });
  }

  Widget checkMyTuneListEmpty() {
    return Obx(() {
      return controller.tuneList.isEmpty ? listIsEmpty() : MyTuneListView();
    });
  }

  Widget checkMyPlayingTuneEmpty() {
    return Obx(() {
      return controller.playingList.isEmpty
          ? listIsEmpty()
          : MyTunePlayingView();
    });
  }

  Widget listIsEmpty() {
    return SizedBox(
      height: 200,
      child: Center(
        child: CustomText(
          title: tuneListEmptyStr.tr,
          fontName: FontName.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget loadInd() {
    return SizedBox(height: 200, child: Center(child: loadingIndicator()));
  }
}
