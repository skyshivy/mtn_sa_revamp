import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/utility/route_direction.dart';

class WebTabView extends StatelessWidget {
  WebTabController tabController = Get.find();
  WebTabView({super.key});
  FAQScreen? faqScreen;
  @override
  Widget build(BuildContext context) {
    //print("width is =============${Get.width}");
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        getPages: routesDirection,
        onGenerateRoute: (settings) {
          print("onGenerateRoute  ${settings.name}");
        },
        home: Material(child: indexed(tabController.index.value)),
      );
    });
  }

  Widget indexed(int value) {
    print("Selected index is ${value}");
    return IndexedStack(
      index: value,
      children: [
        WebLandingPage(),
        //setLandingScreen(),
        const CustomText(title: "title2"),
        loadFaq(value),
        SearchScreen()
      ],
    );
  }

  Widget loadFaq(int value) {
    if (value == 2) {
      if (faqScreen == null) {
        faqScreen = FAQScreen();
        return faqScreen!;
      }
      return faqScreen!;
    } else {
      return faqScreen ?? const SizedBox();
    }
  }
}
