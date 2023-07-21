import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/web_landing_screen.dart';

class WebTabView extends StatelessWidget {
  WebLandingPage? webLandingPage;
  FAQScreen? faqScreen;
  WebTabController tabController = Get.put(WebTabController());
  WebTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return stackWidget(); //WebLandingPage();
  }

  Widget stackWidget() {
    return Obx(() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Material(
              child: tabController.index.value == 0
                  ? setLandingScreen()
                  : setFaqScreen() //returnWidget(tabController.index.value),
              ),
        ],
      );
    });
  }

  Widget returnWidget(int index) {
    print("Indexc tapped $index");
    if (index == 0) {
      return setLandingScreen(); //setScreenOne();
    } else {
      return setFaqScreen();
    }
  }

  Widget setFaqScreen() {
    if (faqScreen == null) {
      faqScreen = FAQScreen();
      return faqScreen!;
    } else {
      return faqScreen!;
    }
  }

  Widget setLandingScreen() {
    if (faqScreen == null) {
      webLandingPage = WebLandingPage();
      return webLandingPage!;
    } else {
      return webLandingPage!;
    }
  }
}
