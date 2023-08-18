import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/drawer_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/drawer_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';

Widget mobileDrawerCell(DrawerModel info) {
  MyDrawerController controller = Get.find();
  return InkWell(
    splashColor: transparent,
    onTap: () {
      if (info.isExpandable!.value) {
        info.isSelected!.value = !info.isSelected!.value;
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: info.title,
                fontName: FontName.medium,
                fontSize: 16,
              ),
              info.isExpandable!.value ? _expandedIcon(info) : const SizedBox()
            ],
          ),
          _subList(info, controller)
        ],
      ),
    ),
  );
}

Widget _expandedIcon(DrawerModel info) {
  return Obx(() {
    return Icon(
      info.isSelected!.value ? Icons.arrow_drop_down : Icons.arrow_forward_ios,
      size: 14,
    );
  });
}

Widget _subList(DrawerModel info, MyDrawerController controller) {
  return Obx(() {
    return info.isSelected!.value
        ? Column(
            children: [
              SizedBox(height: 16),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.catList.length,
                  itemBuilder: (context, index) {
                    return _subListCell(controller, index);
                  }),
            ],
          )
        : const SizedBox();
  });
}

Widget _subListCell(MyDrawerController controller, int index) {
  return InkWell(
    splashColor: transparent,
    hoverColor: transparent,
    //focusColor: transparent,
    onTap: () {
      _tappedOnSubCell(controller.catList[index]);
      // _expandedIcon(info);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Center(
              child: CustomText(
                title: controller.catList[index].categoryName ?? '',
                fontName: FontName.regular,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

_tappedOnSubCell(AppCategory cat) {
  Get.toNamed(tuneCatTapped, parameters: {
    'categoryName': cat.categoryName ?? '',
    'categoryId': cat.categoryId ?? ''
  });
  print("object ==== ${cat.categoryId}");
}
