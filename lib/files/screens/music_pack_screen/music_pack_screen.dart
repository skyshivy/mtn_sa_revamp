import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/music_box_model.dart';
import 'package:mtn_sa_revamp/files/screens/music_pack_screen/music_box_card/music_box_card.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MusicPackScreen extends StatelessWidget {
  MusicPackController cont = Get.put(MusicPackController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return cont.isloading.value ? loadingIndicator(radius: 15) : gridView();
      }),
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return GridView.builder(
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
  }

  SliverGridDelegateWithMaxCrossAxisExtent musicBoxDelegate() {
    return SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400, mainAxisExtent: 120);
  }
}
