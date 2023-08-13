import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

Widget profilePreferenceWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
          title: preferenceStr, fontName: FontName.regular, fontSize: 14),
      SizedBox(height: 6),
      Expanded(child: gridView())
    ],
  );
}

Widget gridView() {
  ProfileController controller = Get.find();
  return Obx(() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.catList.length,
      gridDelegate: delegate(mainAxisExtent: 130, maxCrossAxisExtent: 200),
      itemBuilder: (context, index) {
        return _preferenceGridCell(controller, index);
      },
    );
  });
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
                  gradient: customGredient(blackGredient, blackGredient),
                  borderRadius: BorderRadius.circular(6),
                  color: yellow,
                ),
                child: CustomImage(
                  url: controller.catList[index].menuImagePath,
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

IconButton _profilePrefRadioButtom(ProfileController controller, int index) {
  controller.catList[index].isSelected!.value =
      controller.selectedCatList.contains(controller.catList[index].categoryId);
  return IconButton(
      hoverColor: transparent,
      focusColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onPressed: () {
        if (controller.editEnable.value) {
          controller.updateSelection(index);
          print("Tapped========");
        }

        print("Tapped circle ${controller.catList[index].isSelected!.value}");
      },
      icon: Obx(() {
        return Icon(
          (controller.catList[index].isSelected!.value)
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked,
          color: yellow,
        );
      }));
}
