import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/diy_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DIYNameTextField extends StatelessWidget {
  DIYNameTextField({super.key});
  final DiyController con = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, si) {
      var txt = si.isMobile ? tuneNameStr : nameOfTuneStr;
      TextEditingController cont = TextEditingController();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: txt,
              textColor: si.isMobile ? Colors.black : subTitleColor,
              fontSize: si.isMobile ? 10 : 14,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 45,
              width: si.isMobile ? null : 400,
              decoration: customBoxDeco(si),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(child: textFieldWidget(si, cont)),
              ),
            )
          ],
        ),
      );
    });
  }

  BoxDecoration customBoxDeco(SizingInformation si) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
            color: si.isMobile ? red : Colors.grey.withOpacity(0.4)));
  }

  Widget textFieldWidget(
    SizingInformation si,
    TextEditingController cont,
  ) {
    cont.text = con.tuneName.value;
    cont.selection =
        TextSelection.fromPosition(TextPosition(offset: cont.text.length));
    return TextField(
      onChanged: (str) {
        //value.updateTuneName(str);
      },
      controller: cont,
      style: TextStyle(
        fontFamily: FontName.aheavy.name,
        fontSize: si.isMobile ? 14 : 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: tuneNameHereStr,
        helperStyle: TextStyle(
          color: si.isMobile ? Colors.black : Colors.grey.withOpacity(0.5),
        ),
      ),
    );
  }
}
