import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';

class ImageButton extends StatelessWidget {
  final String imgName;
  final double height;
  final double? width;
  final double? iconHeight;
  final double? iconWidth;
  final bool? isRound;
  final double? radius;
  final Color color;
  const ImageButton({
    super.key,
    required this.imgName,
    this.height = 50,
    this.width,
    this.isRound = true,
    this.radius,
    this.color = Colors.transparent,
    this.iconHeight,
    this.iconWidth,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration(),
      child: Center(
        child: Image.asset(
          imgName,
          width: iconHeight,
          height: iconWidth,
        ),
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(color: color, borderRadius: borderRadius());
  }

  BorderRadius borderRadius() =>
      BorderRadius.circular(isRound! ? (height / 2) : (radius ?? 0));
}
