import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? fontSize;
  final int? maxLine;
  final TextOverflow? overFlow;
  final FontName? fontName;
  final TextAlign? alignment;

  const CustomText({
    super.key,
    required this.title,
    this.textColor = black,
    this.fontSize = 16,
    this.maxLine,
    this.overFlow,
    this.fontName = FontName.medium,
    this.alignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      textAlign: alignment,
      maxLines: maxLine,
      style: TextStyle(
        overflow: overFlow,
        fontFamily: fontName!.name,
        fontSize: (fontSize == null)
            ? fontSize
            : (fontSize! * (StoreManager().isEnglish ? 1 : 0.95)),
        color: textColor,
      ),
    );
  }
}
