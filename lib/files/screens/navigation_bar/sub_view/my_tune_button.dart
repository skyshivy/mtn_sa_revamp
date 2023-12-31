import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/screens/category_screen/category_popup_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';

class HomeMyTuneButton extends StatelessWidget {
  WebTabController controller = Get.find();

  HomeMyTuneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      rightWidget: rightWidget(),
      title: myTuneStr,
      textColor: white,
      fontName: FontName.bold,
      fontSize: 16,
      onTap: () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
          return;
        }
        Get.dialog(CategoryPopupView(
          onTap: (AppCategory category) {
            Get.back();
            Get.toNamed(tuneCatTapped, parameters: {
              "categoryName": category.categoryName ?? '',
              "categoryId": category.categoryId ?? ''
            });
            Navigator.pop(context);
            print("On tap HomeMyTuneButton ${category.categoryName}");
          },
        ));
      },
    );
  }

  Padding rightWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 2),
      child: Icon(
        Icons.arrow_drop_down_outlined,
        color: white,
      ),
    );
  }
}
