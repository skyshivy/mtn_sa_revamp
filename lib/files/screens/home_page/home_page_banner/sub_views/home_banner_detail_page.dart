import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/banner_detail_controller/banner_detail_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeBannerDetailPage extends StatefulWidget {
  const HomeBannerDetailPage({
    super.key,
    required this.type,
    required this.bannerOrder,
    required this.searchKey,
  });
  final String type;
  final String bannerOrder;
  final String searchKey;

  @override
  State<StatefulWidget> createState() {
    return _HomeBannerDetailPageState();
  }
}

class _HomeBannerDetailPageState extends State<HomeBannerDetailPage> {
  late BannerDetailController controller;
  @override
  void initState() {
    controller = Get.find();
    //controller.getDetail(widget.bannerOrder, widget.searchKey);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BannerDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return controller.isloading.value
              ? loadingIndi()
              : controller.list.isEmpty
                  ? emptyWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTopHeaderView(title: bannerDetailStr.tr),
                        Expanded(child: gridView()),
                      ],
                    );
        });
      },
    );
  }

  Widget emptyWidget() {
    return Center(
        child: CustomText(
      title: tuneListEmptyStr.tr,
      fontName: FontName.bold,
    ));
  }

  Widget loadingIndi() {
    return Center(
      child: loadingIndicator(),
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 12 : 30),
          child: Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: controller.list.length,
              gridDelegate:
                  delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
              itemBuilder: (context, index) {
                return cell(index, si);
              },
            );
          }),
        );
      },
    );
  }

  Widget cell(int index, SizingInformation si) {
    return HomeTuneCell(
      si: si,
      index: index,
      info: controller.list[index],
      onTap: si.isMobile
          ? () {
              pushToTunePreView(context, controller.list, index);
            }
          : null,
    );
  }
}
