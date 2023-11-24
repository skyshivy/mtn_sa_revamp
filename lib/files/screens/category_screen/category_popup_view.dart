// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';

class CategoryPopupView extends StatelessWidget {
  final Function(AppCategory)? onTap;
  CategoryPopupView({super.key, this.onTap});

  CategoryPoupupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 70),
        Material(
          color: transparent,
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: white,
                    ),
                    child: categoryListView()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget categoryListView() {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.catList.length,
        itemBuilder: (context, index) {
          return categoryCell(context, index);
        },
      );
    });
  }

  Widget categoryCell(BuildContext context, int index) {
    return InkWell(
      onTap: () async {
        Navigator.pop(context);
        onTap!(controller.catList[index]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 170,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: cellStack(index),
          ),
        ),
      ),
    );
  }

  Stack cellStack(int index) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        CustomImage(
          url: controller.catList[index].menuImagePath,
          gradient: customGredient(blackGredient, blackGredient),
        ),
        Center(
          child: CustomText(
            title: "${controller.catList[index].categoryName}",
            fontName: FontName.medium,
            textColor: white,
          ),
        ),
      ],
    );
  }
}
