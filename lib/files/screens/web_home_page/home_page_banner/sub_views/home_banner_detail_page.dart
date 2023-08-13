import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/banner_detail_controller/banner_detail_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

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
    controller = Get.put(BannerDetailController());
    controller.getDetail(widget.bannerOrder, widget.searchKey);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BannerDetailController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isloading.value
          ? loadingIndi()
          : controller.list.isEmpty
              ? emptyWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTopHeaderView(title: bannerDetailStr),
                      Expanded(child: gridView()),
                    ],
                  ),
                );
    });
  }

  Widget emptyWidget() {
    return const Center(
        child: CustomText(
      title: tuneListEmptyStr,
      fontName: FontName.bold,
    ));
  }

  Widget loadingIndi() {
    return Center(
      child: loadingIndicator(),
    );
  }

  Widget gridView() {
    return Obx(() {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: controller.list.length,
        gridDelegate: delegate(),
        itemBuilder: (context, index) {
          return cell(index);
        },
      );
    });
  }

  Widget cell(int index) {
    return HomeTuneCell(
      index: index,
      info: controller.list[index],
    );
  }
}