import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/web_landing_screen.dart';

class WebTabView extends StatelessWidget {
  WebTabController tabController = Get.put(WebTabController());
  WebTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return indexed(tabController.index.value);
    });
  }

  Widget indexed(int value) {
    return IndexedStack(
      index: value,
      children: [
        const WebLandingPage(),
        //setLandingScreen(),
        const CustomText(title: "title2"),
        FAQScreen(),
        SearchScreen()
      ],
    );
  }
}
