import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/wishlist_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
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
    return Obx(() {
      return wishlistController.isLoading.value
          ? Center(child: loadingIndicator())
          : Center(child: gridView()
              // CustomText(
              //   title: "_WishlistScreenState",
              //   fontName: FontName.bold,
              //   fontSize: 20,
              // ),
              );
    });
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return GridView.builder(
            itemCount: wishlistController.list.length,
            gridDelegate: delegate(si),
            itemBuilder: (context, index) {
              return HomeTuneCell(
                index: index,
                info: wishlistController.list[index],
              );
            },
          );
        });
      },
    );
  }
}
