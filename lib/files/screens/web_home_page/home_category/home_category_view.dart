import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/go_router/app_router.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeCategoryView extends StatelessWidget {
  CategoryPoupupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return SizedBox(
          height: si.isMobile ? 180 : 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerWidget(si),
              const SizedBox(height: 8),
              Expanded(child: listView(si)),
            ],
          ),
        );
      },
    );
  }

  headerWidget(SizingInformation si) {
    return CustomText(
      title: categoryStr,
      fontName: FontName.aheavy,
      fontSize: si.isMobile ? 18 : 25,
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
                child: categoryCell(context, controller.catList[index]));
          });
        },
      );
    });
  }

  Widget categoryCell(BuildContext context, AppCategory info) {
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
            cellTitle(context, info)
          ],
        ),
      ),
    );
  }

  Widget cellTitle(BuildContext context, AppCategory info) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return InkWell(
          onTap: () {
            if (si.isMobile) {
              context.pushNamed(tuneGoRoute, queryParameters: {
                'categoryName': info.categoryName,
                'categoryId': info.categoryId,
              });
            } else {
              context.goNamed(tuneGoRoute, queryParameters: {
                'categoryName': info.categoryName,
                'categoryId': info.categoryId,
              });
            }
          },
          child: Center(
              child: CustomText(
            alignment: TextAlign.center,
            title: (info.categoryName ?? ''),
            textColor: white,
            fontSize: si.isMobile ? 18 : 20,
            fontName: FontName.ztbold,
          )),
        );
      },
    );
  }
}
