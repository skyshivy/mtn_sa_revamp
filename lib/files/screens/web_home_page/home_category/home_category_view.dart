import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeCategoryView extends StatelessWidget {
  CategoryPoupupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return SizedBox(
          height: si.isMobile ? 180 : 220,
          child: listView(si),
        );
      },
    );
  }

  Widget listView(SizingInformation si) {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.catList.length,
        itemBuilder: (context, index) {
          return Obx(() {
            return Padding(
                padding: EdgeInsets.only(
                  right: appCont.isEnglish.value ? (si.isMobile ? 8 : 18) : 0,
                  left: appCont.isEnglish.value ? 0 : (si.isMobile ? 8 : 18),
                ),
                child: categoryCell(controller.catList[index]));
          });
        },
      );
    });
  }

  Widget categoryCell(AppCategory info) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            CustomImage(
              url: info.menuImagePath,
              gradient: customImageGredient(),
            ),
            cellTitle(info)
          ],
        ),
      ),
    );
  }

  Widget cellTitle(AppCategory info) {
    return Center(child: ResponsiveBuilder(
      builder: (context, si) {
        return CustomText(
          alignment: TextAlign.center,
          title: (info.categoryName ?? ''),
          textColor: white,
          fontSize: si.isMobile ? 18 : 25,
          fontName: FontName.ztbold,
        );
      },
    ));
  }
}
