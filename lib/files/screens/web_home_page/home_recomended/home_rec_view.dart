import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_mobile_nav_bar.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/tune_preview_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_reco_tab_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingRecoView extends StatefulWidget {
  const LandingRecoView({super.key});

  @override
  State<LandingRecoView> createState() => _LandingRecoViewState();
}

class _LandingRecoViewState extends State<LandingRecoView> {
  RecoController controller = Get.put(RecoController());
  late SizingInformation si;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        this.si = sizingInformation;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: si.isMobile ? 10 : 30),
              const HomeRecoTabView(),
              SizedBox(height: si.isMobile ? 10 : 40),
              gridView(),
              seeMoreButton(si),
            ],
          ),
        );
      },
    );
  }

  Widget seeMoreButton(SizingInformation si) {
    return Obx(() {
      return Visibility(
        visible: ((controller.displayList!.length > 8)),
        child: Padding(
          padding: EdgeInsets.only(top: si.isMobile ? 10 : 50),
          child: CustomButton(
            onTap: () {
              Get.toNamed(seeMoreTapped);
              print("See more tapped");
            },
            title: seeMoreStr,
            fontName: FontName.bold,
            fontSize: si.isMobile ? 12 : 18,
          ),
        ),
      );
    });
  }

  Widget gridView() {
    return Obx(() {
      int? count = ((controller.displayList?.length ?? 0) > 8)
          ? 8
          : controller.displayList?.length;
      return controller.isLoading.value
          ? loadingIndicator()
          : ResponsiveBuilder(
              builder: (context, si) {
                return GridView.builder(
                    itemCount: count,
                    shrinkWrap: true,
                    gridDelegate: delegate(si,
                        mainAxisExtent: si.isMobile ? 230 : null,
                        mainAxisSpacing: si.isMobile ? 8 : null,
                        crossAxisSpacing: si.isMobile ? 8 : null),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return homeCell(index);
                    });
              },
            );
    });
  }

  Widget homeCell(int index) {
    return ResponsiveBuilder(builder: (context, si) {
      return HomeTuneCell(
        info: controller.displayList?[index],
        index: index,
        onTap: si.isMobile
            ? () {
                print("homeCell tapped");
                pushToTunePreView(context, controller.displayList, index);
              }
            : null,
      );

      //si.isMobile ? : SizedBox();
    });
  }
}
