import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';

showPositionedPopup(GlobalKey key, List<MenuModel> menuList,
    {bool isLeft = false, double? width, Function(MenuModel)? onTap}) {
  RenderBox renderbox = key.currentContext!.findRenderObject() as RenderBox;
  Size size = renderbox.size;

  RenderBox? box = key.currentContext!.findRenderObject() as RenderBox?;

  Offset position = box!.localToGlobal(Offset.zero);
  double xPosition = position.dx;
  double yPosition = position.dy;

  Get.dialog(
    Stack(
      children: [
        Positioned(
          left: isLeft ? (xPosition - (width ?? size.width) + 30) : xPosition,
          top: yPosition + size.height + 4,
          child: Material(
            color: transparent,
            child: SizedBox(
                width: width ?? size.width,
                child: _widgetDecoration(menuList, onTap)),
          ),
        ),
      ],
    ),
  );
}

Widget _widgetDecoration(List<MenuModel> menuList, Function(MenuModel)? onTap) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: mainContainerDecoration(menuList),
    child: _customMenuListView(menuList, onTap),
  );
}

BoxDecoration mainContainerDecoration(List<MenuModel> menuList) {
  return BoxDecoration(
    border: Border.all(color: white),
    borderRadius: BorderRadius.circular(4),
    color: white,
  );
}

Widget _customMenuListView(
    List<MenuModel> menuList, Function(MenuModel)? onTap) {
  return ListView.builder(
      itemCount: menuList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomOnHover(builder: (isHover) {
          return GestureDetector(
            onTap: () {
              Get.back();
              Navigator.pop(context);
              onTap!(menuList[index]);
            },
            child: Container(
                color: isHover ? yellow : transparent,
                child: cell(menuList, index)),
          );
        });
      });
}

Padding cell(List<MenuModel> menuList, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        cellImage(menuList[index]),
        customSpacer(menuList, index),
        cellTitle(menuList[index]),
      ],
    ),
  );
}

SizedBox customSpacer(List<MenuModel> menuList, int index) {
  return (menuList[index].imageName == null)
      ? const SizedBox()
      : const SizedBox(width: 8);
}

Widget cellTitle(MenuModel menu) {
  return CustomText(
    title: menu.title,
    fontName: FontName.regular,
  );
}

Widget cellImage(MenuModel menu) {
  return (menu.imageName == null)
      ? const SizedBox()
      : SizedBox(
          height: 20, width: 20, child: Image.asset(menu.imageName ?? ''));
}
