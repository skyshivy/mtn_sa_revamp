// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
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
        const SizedBox(
          height: 102,
        ),
        Material(
          color: transparent,
          child: Row(
            children: [
              const SizedBox(width: 160),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: white),
                  borderRadius: BorderRadius.circular(2),
                  color: white,
                ),
                width: 200, //MediaQuery.of(context).size.width,

                child: categoryListView(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryListView() {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: controller.catList.length,
        itemBuilder: (context, index) {
          return categoryCell(context, index);
        },
      );
    });
  }

  Widget categoryCell(BuildContext context, int index) {
    return CustomOnHover(
      builder: (isHovered) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              gradient: isHovered
                  ? const LinearGradient(colors: [darkGreen, lightGreen])
                  : null),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
              onTap!(controller.catList[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: SizedBox(
                width: 170,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CustomText(
                        textColor: isHovered ? white : black,
                        title:
                            "${controller.catList[index].categoryName}") //cellStack(index),
                    ),
              ),
            ),
          ),
        );
      },
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
            fontName: FontName.abook,
            textColor: white,
          ),
        ),
      ],
    );
  }
}
