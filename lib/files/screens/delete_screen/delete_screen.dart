import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/delete_controller.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class DeleteScreen extends StatefulWidget {
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
    return Center(child: buttonsColumn() //customColumn(),
        );
  }

  Widget buttonsColumn() {
    return Column(
      children: [
        buttonOne(),
        SizedBox(height: 10),
        buttonTwo(),
        SizedBox(height: 10),
        buttonThree()
      ],
    );
  }

  Widget buttonOne() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ElevatedButton.icon(
          // <-- ElevatedButton
          onPressed: () {},
          icon: SizedBox(
            height: 40,
            child: Icon(
              Icons.radio_button_checked,
              size: 20.0,
            ),
          ),
          label: CustomText(title: 'ElevatedButton Radio'),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          // <-- ElevatedButton
          onPressed: () {},
          icon: SizedBox(
            height: 40,
            child: Icon(
              Icons.download,
              size: 20.0,
            ),
          ),
          label: CustomText(title: 'ElevatedButton'),
        ),
        TextButton.icon(
          // <-- TextButton
          onPressed: () {},
          icon: SizedBox(
            height: 40,
            child: Icon(
              Icons.download,
              size: 20.0,
            ),
          ),
          label: CustomText(title: 'TextButton'),
          //label: Text('TextButton'),
        ),
        OutlinedButton.icon(
          // <-- OutlinedButton
          onPressed: () {},
          icon: SizedBox(
            height: 40,
            child: Icon(
              Icons.download,
              size: 20.0,
            ),
          ),
          label: CustomText(title: 'OutlinedButton'),
          //label: Text('OutlinedButton'),
        ),
      ],
    );
  }

  Widget buttonTwo() {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ElevatedButton row'), // <-- Text
            SizedBox(
              width: 5,
            ),
            Icon(
              // <-- Icon
              Icons.download,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonThree() {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ElevatedButton row radio'), // <-- Text
            SizedBox(
              width: 5,
            ),
            Icon(
              // <-- Icon
              Icons.radio_button_checked,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Column customColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Container(
                height: deCont.isCHanged.value ? 150 : 150,
                width: deCont.isCHanged.value ? 100 : 200,
                color: blue,
              ));
        }),
        const SizedBox(height: 30),
        animateButton(),
        const SizedBox(height: 30),
        Obx(() {
          return CustomButton(
            height: 100,
            width: 300,
            color: appCont.isLoggedIn.value ? red : blue,
            textColor: appCont.isLoggedIn.value ? blue : red,
            radius: 10,
            fontName: FontName.bold,
            fontSize: 20,
            title:
                "Change Color ${!(appCont.isLoggedIn.value) ? "red" : "blue"}",
            onTap: () {
              StoreManager().setLoggedIn(!StoreManager()
                  .isLoggedIn); //setTestBool(!StoreManager().isLoggedIn);
            },
          );
        }),
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
