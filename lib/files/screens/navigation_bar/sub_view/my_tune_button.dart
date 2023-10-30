import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/hover_menu.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_popup_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';

class HomeMyTuneButton extends StatelessWidget {
  final Function(AppCategory category) onTap;

  HomeMyTuneButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return HoverMenu(
        focusNode: mainFocusNode,
        widget: Container(
          height: 150,
          color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  mainFocusNode.unfocus();
                  print("tapped index is $index");
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    color: Colors.amber,
                    height: 40,
                    width: 50,
                  ),
                ),
              );
            },
          ),
        ),
        title: Container(
          child: mainButton(),
        ));
    //mainButton();
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
