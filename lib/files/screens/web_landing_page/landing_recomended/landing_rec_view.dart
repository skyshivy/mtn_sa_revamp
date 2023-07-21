import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/landing_recomended/sub_views/home_reco_tab_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/landing_recomended/sub_views/tune_cell.dart';

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
      return GridView.builder(
          itemCount: controller.items.value,
          shrinkWrap: true,
          gridDelegate: delegate(),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return HomeTuneCell(
              index: index,
            );
          });
    });
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
