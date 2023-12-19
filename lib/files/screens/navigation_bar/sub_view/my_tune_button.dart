import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/hover_menu.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_popup_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';

class HomeMyTuneButton extends StatefulWidget {
  final Function(AppCategory category) onTap;
  const HomeMyTuneButton({super.key, required this.onTap});
  @override
  State<StatefulWidget> createState() {
    return _HomeMyTuneButtonState();
  }
}

class _HomeMyTuneButtonState extends State<HomeMyTuneButton> {
  CategoryPoupupController controller = Get.find();
  @override
  void initState() {
    mainFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HoverMenu(
      focusNode: mainFocusNode,
      widget: Container(
        height: 180,
        color: transparent,
        width: MediaQuery.of(context).size.width - 200,
        child: Row(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), color: white),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Obx(() {
                      return controller.isLoadingCat.value
                          ? Center(child: loadingIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.catList.length,
                              itemBuilder: (context, index) {
                                return myTuneCell(index);
                              },
                            );
                    })),
              ),
            ),
          ],
        ),
      ),
      title: Container(
        child: mainButton(),
      ),
    );
    //mainButton();
  }

  InkWell myTuneCell(int index) {
    double padding = 3;
    return InkWell(
      onTap: () {
        mainFocusNode.unfocus();
        print("tapped index is $index");
        widget.onTap(controller.catList[index]);
      },
      child: customPadding(padding, index),
    );
  }

  Widget customPadding(double padding, int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: padding,
        bottom: padding,
        left: index == 0 ? 0 : padding,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: mainContaner(index),
      ),
    );
  }

  Widget mainContaner(int index) {
    return CustomOnHover(
      builder: (isHovered) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            //width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImage(
                  gradient: customImageGredient(
                      color1: isHovered ? transparent : blackGredient,
                      color2: isHovered ? transparent : blackGredient),
                  url: controller.catList[index].menuImagePath,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomText(
                    title: controller.catList[index].categoryName ?? '',
                    textColor: white,
                    fontName: FontName.aheavy,
                    fontSize: 18,
                    alignment: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mainButton() {
    return CustomButton(
      rightWidget: rightWidget(),
      title: tuneStr,
      textColor: white,
      fontName: FontName.aheavy,
      fontSize: 18,
      onTap: () async {
        print("tune tapped");
        mainFocusNode.requestFocus();
        // Get.dialog(
        //   CategoryPopupView(
        //     onTap: (AppCategory category) {
        //       widget.onTap(category);
        //     },
        //   ),
        // );
      },
    );
  }

  Padding rightWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 0),
      child: Icon(
        Icons.arrow_drop_down,
        color: white,
        size: 20,
      ),
    );
  }
}
