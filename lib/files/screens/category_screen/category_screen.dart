import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';

class CategoryScreen extends StatefulWidget {
  final String id;
  final String category;
  const CategoryScreen({super.key, required this.category, required this.id});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController controller = Get.put(CategoryController());
  @override
  void initState() {
    controller.getCategroyDetail(widget.category, widget.id);
    print("on init state");
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CategoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(title: widget.category),
        Expanded(child: gridView()),
        loadMoreActivity()
      ],
    );
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

  Widget gridView() {
    return Obx(
      () {
        return controller.isLoading.value
            ? loadingIndicator()
            : GridView.builder(
                shrinkWrap: true,
                itemCount: controller.searchList.length,
                gridDelegate: delegate(),
                itemBuilder: (context, index) {
                  return HomeTuneCell(index: index);
                });
      },
    );
  }
}
