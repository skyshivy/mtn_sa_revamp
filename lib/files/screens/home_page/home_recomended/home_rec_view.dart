import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_mobile_nav_bar.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/tune_preview_screen.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_reco_tab_view.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingRecoView extends StatefulWidget {
  const LandingRecoView({
    super.key,
  });

  @override
  State<LandingRecoView> createState() => _LandingRecoViewState();
}

class _LandingRecoViewState extends State<LandingRecoView> {
  RecoController controller = Get.find();

  late SizingInformation si;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        this.si = sizingInformation;
        return Column(
          children: [
            SizedBox(height: si.isMobile ? 10 : 30),
            const HomeRecoTabView(),
            SizedBox(height: si.isMobile ? 10 : 20),
            gridView(),
            seeMoreButton(context, si),
          ],
        );
      },
    );
  }

  Widget seeMoreButton(BuildContext context, SizingInformation si) {
    return Obx(() {
      return Visibility(
        visible: ((controller.displayList!.length > 8)),
        child: Padding(
          padding: EdgeInsets.only(top: si.isMobile ? 10 : 50),
          child: CustomButton(
            onTap: () {
              //Get.toNamed(seeMoreTapped);
              List<TuneInfo>? list = controller.displayList?.value;

              print("List is $list");

              context.pushNamed(moreRecoGoRoute, extra: list, queryParameters: {
                '': controller.tabTitle[controller.selectedIndex.value]
              });
              print("See more tapped");
            },
            title: seeMoreStr,
            fontName: FontName.aheavy,
            fontSize: si.isMobile ? 12 : 18,
          ),
        ),
      );
    });
  }

  Widget gridView() {
    const double runSpacing = 8;
    const double spacing = 8;

    double w = 240;
    double h = 250;
    return Obx(() {
      int listSize = (((controller.displayList?.length ?? 0) > 8)
              ? 8
              : controller.displayList?.length) ??
          0;

      return controller.isLoading.value
          ? SizedBox(height: 200, child: loadingIndicator())
          : ResponsiveBuilder(
              builder: (context, si) {
                return si.isMobile
                    ? GridView.builder(
                        itemCount: listSize,
                        shrinkWrap: true,
                        gridDelegate: delegate(si,
                            mainAxisExtent: si.isMobile ? 230 : null,
                            mainAxisSpacing: si.isMobile ? 8 : null,
                            crossAxisSpacing: si.isMobile ? 8 : null),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return homeCell(index);
                        })
                    : Wrap(
                        runSpacing: runSpacing,
                        spacing: spacing,
                        alignment: WrapAlignment.center,
                        children: List.generate(listSize, (index) {
                          return SizedBox(
                            height: h,
                            width: w,
                            child: homeCell(index),
                          );
                        }),
                      );
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