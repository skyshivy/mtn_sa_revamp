import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_reco_tab_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';

class LandingRecoView extends StatefulWidget {
  const LandingRecoView({super.key});

  @override
  State<LandingRecoView> createState() => _LandingRecoViewState();
}

class _LandingRecoViewState extends State<LandingRecoView> {
  RecoController controller = Get.put(RecoController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          const HomeRecoTabView(),
          const SizedBox(height: 40),
          gridView(),
        ],
      ),
    );
  }

  Widget gridView() {
    return Obx(() {
      int? count = ((controller.displayList?.length ?? 0) > 8)
          ? 8
          : controller.displayList?.length;
      return controller.isLoading.value
          ? loadingIndicator()
          : GridView.builder(
              itemCount: count,
              shrinkWrap: true,
              gridDelegate: delegate(),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return homeCell(index);
              });
    });
  }

  HomeTuneCell homeCell(int index) {
    return HomeTuneCell(
      info: controller.displayList?[index],
      index: index,
      onTap: () {
        print("homeCell tapped");
      },
    );
  }

  SliverGridDelegateWithMaxCrossAxisExtent delegate() {
    return const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.911,
        mainAxisExtent: 280,
        maxCrossAxisExtent: 290,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20);
  }
}
