import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WishlistScreenState();
  }
}

class _WishlistScreenState extends State<WishlistScreen> {
  late WishlistController wishlistController;
  @override
  void initState() {
    wishlistController = Get.put(WishlistController());
    getWishlist();
    super.initState();
  }

  getWishlist() async {
    await Future.delayed(const Duration(milliseconds: 200));
    wishlistController.getWishlist();
  }

  @override
  void dispose() {
    Get.delete<WishlistController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return wishlistController.isLoading.value
                ? Center(child: loadingIndicator())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomTopHeaderView(title: wishlistStr),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: si.isMobile ? 8 : 30),
                          child: gridView(),
                        ),
                      ),
                    ],
                  );
          },
        );
      },
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(
          () {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: wishlistController.wishlist.length,
              gridDelegate: delegate(si),
              itemBuilder: (context, index) {
                return HomeTuneCell(
                  info: wishlistController.wishlist[index],
                  isWishlist: true,
                  index: index,
                );
              },
            );
          },
        );
      },
    );
  }
}
