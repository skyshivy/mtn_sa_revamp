import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/cryptor/decryptor.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class DeleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
//encrypted<msisdn=9255265120&ccid=admin&userName=ccare&password=ccare&channel=ccportal>
              String enc = Decryptor().aesEnc(
                  "msisdn=9975654677&ccid=admin&userName=ccare&password=ccare&channel=ccportal");
              print("enc = \n $enc ");

              print("dec = \n ${Decryptor().decryptWithAES(enc)}");
            },
          )
        ],
      ),
    );
  }
}
