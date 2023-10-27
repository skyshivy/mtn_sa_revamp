import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CategoryScreen extends StatefulWidget {
  final String id;
  final String category;
  const CategoryScreen({super.key, required this.category, required this.id});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController catContcontroller = Get.find();
  late ScrollController _scrollCont;
  @override
  void initState() {
    super.initState();
    _scrollCont = ScrollController();
    _scrollCont.addListener(() {
      _scrollListener();
    });
    getCatList();
    print("on init state");
  }

  _scrollListener() {
    if (_scrollCont.offset >= _scrollCont.position.maxScrollExtent) {
      setState(() {
        //catContcontroller.loadMoreData();
        print("reach the bottom");
      });
    }
    if (_scrollCont.offset <= _scrollCont.position.minScrollExtent &&
        !_scrollCont.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  getCatList() async {
    await Future.delayed(const Duration(milliseconds: 100));
    catContcontroller.resetValue();
    await Future.delayed(const Duration(milliseconds: 100));

    catContcontroller.getCategroyDetail(widget.category, widget.id);
  }

  @override
  void dispose() {
    print("Disposed _CategoryScreenState");
    //Get.delete<CategoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTopHeaderView(title: widget.category),
          Expanded(child: gridView()),
          loadMoreActivity()
        ],
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 30),
    //   child:
    // );
  }

  Widget loadMoreActivity() {
    return Obx(() {
      return catContcontroller.isLoadMore.value
          ? loadingIndicator(radius: 12)
          : catContcontroller.isHideLoadMore.value
              ? const SizedBox()
              : loadMoreDataButton(
                  isLoading: catContcontroller.isLoadMore.value,
                  rightAction: () {
                    catContcontroller.loadMoreData();
                  },
                );
    });
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return catContcontroller.isLoading.value
                ? loadingIndicator()
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: si.isMobile ? 8 : 30, vertical: 8),
                    child: GridView.builder(
                        controller: _scrollCont,
                        shrinkWrap: true,
                        itemCount: catContcontroller.searchList.length,
                        gridDelegate: delegate(si,
                            mainAxisExtent: si.isMobile ? 230 : null),
                        itemBuilder: (context, index) {
                          return HomeTuneCell(
                            index: index,
                            info: catContcontroller.searchList[index],
                            onTap: si.isMobile
                                ? () {
                                    pushToTunePreView(context,
                                        catContcontroller.searchList, index);
                                  }
                                : null,
                          );
                        }),
                  );
          },
        );
      },
    );
  }
}
