import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';
import 'package:mtn_sa_revamp/flies/utility/string.dart';

class BuyAndPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: playButtonWidget()),
        SizedBox(
          width: 20,
        ),
        Expanded(child: buyButtonWidget()),
      ],
    );
  }

  Widget playButtonWidget() {
    return const CustomButton(
      fontName: FontName.medium,
      fontSize: 16,
      titlePadding: EdgeInsets.all(4),
      borderColor: red,
      leftWidget: Icon(Icons.play_arrow),
      title: play,
    );
  }

  Widget buyButtonWidget() {
    return const CustomButton(
      color: yellow,
      titlePadding: EdgeInsets.all(4),
      fontName: FontName.bold,
      fontSize: 16,
      leftWidget: Icon(
        Icons.shopping_bag_outlined,
        color: white,
        size: 16,
      ),
      title: buy,
    );
  }
}
