import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/model/menu_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class HomeMoreButton extends StatefulWidget {
  const HomeMoreButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeMoreButtonState();
  }
}

class _HomeMoreButtonState extends State<HomeMoreButton> {
  List<MenuModel> menuItem = [
    MenuModel("Shiv"),
    MenuModel("Kumar"),
    MenuModel("Yadav", imageName: buyImg),
    MenuModel("SKY", imageName: likeImg),
  ];
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 30,
      width: 30,
      color: Colors.white38,
      leftWidget: const Icon(
        Icons.more_horiz,
        color: white,
      ),
      onTap: () {
        showPositionedPopup(
          _key,
          menuItem,
          width: 140,
          isLeft: true,
          onTap: (p0) {
            print("Item name is ${p0.title}");
          },
        );
      },
    );
  }
}
