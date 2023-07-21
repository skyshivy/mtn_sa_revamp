import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final int? maxLine;
  final FontName? fontName;
  final TextAlign? alignment;

  const CustomText({
    super.key,
    required this.title,
    this.textColor = black,
    this.fontSize = 16,
    this.maxLine,
    this.fontName = FontName.regular,
    this.alignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alignment,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: fontName!.name,
        fontSize: fontSize,
        color: textColor,
      ),
    );
  }
}
