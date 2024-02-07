import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/delete_controller.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';

import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  late DeleteController deCont;
  AppController appCont = Get.find();
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
    return Center(child: customColumn() //buttonsColumn() //customColumn(),
        );
  }

  Column customColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                "msisdn=9791001186&ccid=admin&userName=ccare&password=imiuser@mw1&channel=4");
            printCustom("enc = \n $enc ");

            printCustom("dec = \n ${Decryptor().decryptWithAES(enc)}");
          },
        )
      ],
    );
  }
}
