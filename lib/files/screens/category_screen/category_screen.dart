import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_cell_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_empty_tune_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell1.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell2.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CategoryScreen extends StatefulWidget {
  final String id;
  final String category;
  const CategoryScreen({super.key, required this.category, required this.id});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController controller = Get.find();

  @override
  void initState() {
    super.initState();

    //getCatList();
    printCustom("on init state");
  }

  getCatList() async {
    await Future.delayed(const Duration(milliseconds: 100));
    controller.resetValue();
    await Future.delayed(const Duration(milliseconds: 100));

    controller.getCategroyDetail(widget.category, widget.id);
  }

  @override
  void dispose() {
    printCustom("Disposed _CategoryScreenState");
    Get.delete<CategoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(title: widget.category),
        Expanded(
          child: ResponsiveBuilder(
            builder: (context, si) {
              controller.si = si;
              return Obx(
                () {
                  return controller.isLoading.value
                      ? loadingIndicator()
                      : controller.searchList.isEmpty
                          ? customEmptyTuneView()
                          : customGridView(si: si); //mainGridview(si);
                },
              );
            },
          ),
        ),
        loadMoreActivity()
      ],
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 30),
    //   child:
    // );
  }

  Widget loadMoreActivity() {
    return Obx(() {
      return controller.isLoadMore.value
          ? loadingIndicator(radius: 12)
          : controller.isHideLoadMore.value
              ? const SizedBox()
              : loadMoreDataButton(
                  isLoading: controller.isLoadMore.value,
                  rightAction: () {
                    controller.loadMoreData();
                  },
                );
    });
  }
}

class customGridView extends StatelessWidget {
  final SizingInformation si;

  const customGridView({super.key, required this.si});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.find();
    TuneCellController cellCont = Get.find();
    cellCont.tuneList.value = controller.searchList;
    cellCont.si = si;
    cellCont.isWishlist = false;
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30, vertical: 8),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  printCustom('Is mobile ${si.isMobile}');
                  return HomeTuneCell2(
                    index: index,
                  );
                }, childCount: controller.searchList.length),
                gridDelegate:
                    delegate(si, mainAxisExtent: si.isMobile ? 230 : null))
          ],
        ));
  }
}
