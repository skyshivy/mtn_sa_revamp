import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/category_controller/category_popup_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/hover_menu.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_popup_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';

class HomeMyTuneButton extends StatelessWidget {
  final Function(AppCategory category) onTap;
  CategoryPoupupController controller = Get.find();
  HomeMyTuneButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverMenu(
        focusNode: mainFocusNode,
        widget: Container(
          height: 120,
          width: MediaQuery.of(context).size.width - 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.catList.length,
              itemBuilder: (context, index) {
                return myTuneCell(index);
              },
            ),
          ),
        ),
        title: Container(
          child: mainButton(),
        ));
    //mainButton();
  }

  InkWell myTuneCell(int index) {
    double padding = 2;
    return InkWell(
      onTap: () {
        mainFocusNode.unfocus();
        print("tapped index is $index");
      },
      child: customPadding(padding, index),
    );
  }

  Padding customPadding(double padding, int index) {
    return Padding(
      padding: EdgeInsets.only(
          top: padding,
          bottom: padding,
          right: padding,
          left: index == 0 ? 0 : padding),
      child: mainContaner(index),
    );
  }

  Widget mainContaner(int index) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: Colors.amber,
        width: 50,
        child: CustomImage(
          url: controller.catList[index].menuImagePath,
        ),
      ),
    );
  }

  Widget mainButton() {
    return CustomButton(
      rightWidget: rightWidget(),
      title: tuneStr,
      textColor: white,
      fontName: FontName.ztbold,
      fontSize: 16,
      onTap: () async {
        print("tune tapped");
        Get.dialog(
          CategoryPopupView(
            onTap: (AppCategory category) {
              onTap(category);
            },
          ),
        );
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
