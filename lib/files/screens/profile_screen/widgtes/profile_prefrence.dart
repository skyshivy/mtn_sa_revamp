import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget profilePreferenceWidget(
    SizingInformation si, ProfileController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const CustomText(
          title: preferenceStr, fontName: FontName.regular, fontSize: 14),
      const SizedBox(height: 6),
      si.isMobile ? alignedGrid(si, controller) : Flexible(child: gridView(si))
    ],
  );
}

Widget gridView(SizingInformation si) {
  ProfileController controller = Get.find();
  return Obx(() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.catList.length,
      gridDelegate: delegate(si, mainAxisExtent: 130, maxCrossAxisExtent: 200),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              if (controller.editEnable.value) {
                controller.updateSelection(index);
                print("Tapped========");
              }
              print(
                  "Tapped circle ${controller.catList[index].isSelected!.value}");
            },
            child: _preferenceGridCell(controller, index));
      },
    );
  });
}

Widget alignedGrid(SizingInformation si, ProfileController controller) {
  return ResponsiveBuilder(
    builder: (context, sizingInformation) {
      return Row(
        children: [
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width - 40,
            child: Wrap(
              spacing: 8,
              runSpacing: 8, // space between items
              children: [
                for (int i = 0; i < controller.catList.length; i++)
                  custText(controller.catList[i], i, controller)
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget custText(AppCategory item, int index, ProfileController controller) {
  item.isSelected!.value = controller.selectedCatList.contains(item.categoryId);
  return Obx(() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        hoverColor: transparent,
        onTap: () {
          print("Title is = $item");
          if (controller.editEnable.value) {
            controller.updateSelection(index);
            print("Tapped========");
          }
          print("Tapped circle ${controller.catList[index].isSelected!.value}");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: item.isSelected!.value ? blue : Colors.grey.withOpacity(0.4),
            shape: const StadiumBorder(),
          ),
          child: CustomText(title: item.categoryName ?? ''),
        ),
      ),
    );
  });
}

Widget alignCellWidget(int index, SizingInformation sizeInfo) {
  return CustomButton(title: 'index $index');
}

Widget _preferenceGridCell(ProfileController controller, int index) {
  return ClipRRect(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: blueLight,
                ),
                child: CustomImage(
                  url: controller.catList[index].menuImagePath,
                  gradient: customGredient(blackGredient, blackGredient),
                ),
              ),
              _profilePrefRadioButtom(controller, index)
            ],
          ),
        ),
        const SizedBox(height: 2),
        CustomText(
          title: controller.catList[index].categoryName ?? '',
          maxLine: 1,
          fontName: FontName.medium,
          fontSize: 15,
        )
      ],
    ),
  );
}

Widget _profilePrefRadioButtom(ProfileController controller, int index) {
  controller.catList[index].isSelected!.value =
      controller.selectedCatList.contains(controller.catList[index].categoryId);
  return Obx(() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        (controller.catList[index].isSelected!.value)
            ? Icons.radio_button_checked
            : Icons.radio_button_unchecked,
        color: blue,
      ),
    );
  });
}
