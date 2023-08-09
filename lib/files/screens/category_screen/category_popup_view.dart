// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';

class CategoryPopupView extends StatelessWidget {
  CategoryPopupView({super.key});

  CategoryPoupupController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            color: white,
            child: categoryListView(),
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
          return categoryCell(index);
        },
      );
    });
  }

  Padding categoryCell(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: cellStack(index),
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
            fontName: FontName.regular,
            textColor: white,
          ),
        ),
      ],
    );
  }
}
