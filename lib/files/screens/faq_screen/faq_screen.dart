import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class FAQScreen extends StatelessWidget {
  AppController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: white,
        child: Center(child: CustomText(title: "FA")),
      ),
    );
  }
}
