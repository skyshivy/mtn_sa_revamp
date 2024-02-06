import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:mtn_sa_revamp/files/controllers/music_box_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_empty_tune_view.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';

import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';

import 'package:mtn_sa_revamp/files/screens/music_pack_screen/music_box_card/music_box_card.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicPackScreen extends StatelessWidget {
  final MusicPackController cont = Get.put(MusicPackController());

  MusicPackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(
          title: musicPackStr.tr,
        ),
        Expanded(
          child: Obx(() {
            return cont.isloading.value ? loadingIndicator() : gridView();
          }),
        ),
      ],
    );
  }

  Widget gridView() {
    return Obx(() {
      return cont.list.isEmpty
          ? customEmptyTuneView()
          : ResponsiveBuilder(
              builder: (context, si) {
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shrinkWrap: true,
                  itemCount: cont.list.length,
                  gridDelegate: musicBoxDelegate(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MusicBoxCard(info: cont.list[index]),
                    );
                  },
                );
              },
            );
    });
  }

  SliverGridDelegateWithMaxCrossAxisExtent musicBoxDelegate() {
    return const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400, mainAxisExtent: 120);
  }
}
