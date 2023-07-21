import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class BuyAndPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: playButtonWidget()),
        const SizedBox(width: 20),
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
      leftWidget: Icon(Icons.pause), //Icon(Icons.play_arrow),
      title: play,
    );
  }

  Widget buyButtonWidget() {
    return CustomButton(
      color: yellow,
      titlePadding: const EdgeInsets.all(4),
      fontName: FontName.bold,
      fontSize: 16,
      leftWidget: Image.asset(
        buyImg,
        height: 20,
        width: 20,
      ),
      title: buy,
    );
  }
}
