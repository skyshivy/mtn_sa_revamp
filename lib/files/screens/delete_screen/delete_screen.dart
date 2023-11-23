import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/delete_controller.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class DeleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  late DeleteController deCont;
  @override
  void initState() {
    deCont = Get.put(DeleteController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DeleteController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: deCont.isCHanged.value ? firstWidget() : secondWidget(),
            );
          }),
          SizedBox(height: 30),
          animateButton(),
          SizedBox(height: 30),
          CustomButton(
            width: 200,
            radius: 4,
            textColor: white,
            fontName: FontName.bold,
            color: Colors.lightBlue,
            title: "encrypt",
            onTap: () {
//encrypted<msisdn=9255265120&ccid=admin&userName=ccare&password=imiuser@mw1&channel=ccportal>
              String enc = Decryptor().aesEnc(
                  "msisdn=9975654677&ccid=admin&userName=ccare&password=imiuser@mw1&channel=4");
              printCustom("enc = \n $enc ");

              printCustom("dec = \n ${Decryptor().decryptWithAES(enc)}");
            },
          )
        ],
      ),
    );
  }

  Widget firstWidget() {
    return Container(
      height: 200,
      width: 200,
      color: red,
    );
  }

  Widget secondWidget() {
    return Container(
      height: 150,
      width: 150,
      color: blue,
    );
  }

  Widget animateButton() {
    return CustomButton(
      color: blue,
      textColor: white,
      width: 200,
      title: "Animate",
      onTap: () {
        print("Change status");
        deCont.animate();
      },
    );
  }
}
