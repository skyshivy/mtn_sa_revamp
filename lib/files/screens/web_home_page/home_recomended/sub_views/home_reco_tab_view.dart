import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class HomeRecoTabView extends StatefulWidget {
  const HomeRecoTabView({super.key});

  @override
  State<HomeRecoTabView> createState() => _HomeRecoTabViewState();
}

class _HomeRecoTabViewState extends State<HomeRecoTabView> {
  RecoController controller = Get.find();
  @override
  void initState() {
    controller.getTabList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<RecoController>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: listView(),
    );
  }

  Widget listView() {
    return ListView.builder(
        itemCount: controller.tabTitle.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: mainContainer(index),
          );
        });
  }

  Container mainContainer(int index) {
    return Container(
      child: InkWell(
        onTap: () {
          controller.updateSelectedIndex(index);
          //value.selectedTab(index);
        },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [instrinsicWidget(index)],
        ),
      ),
    );
  }

  Widget instrinsicWidget(int index) {
    return Obx(() {
      return IntrinsicWidth(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomText(
            title: controller.tabTitle[index],
            fontName: (controller.selectedIndex.value == index)
                ? FontName.bold
                : FontName.regular,
            fontSize: (controller.selectedIndex.value == index) ? 20 : 20,
            textColor:
                (controller.selectedIndex.value == index) ? yellow : grey,
          ),
          const SizedBox(height: 5),
          selectionIndicator(index)
        ],
      ));
    });
  }

  Container selectionIndicator(int index) {
    return Container(
        height: 3,
        color: controller.selectedIndex.value == index ? yellow : transparent);
  }
}