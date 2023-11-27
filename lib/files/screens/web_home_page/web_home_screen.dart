import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/subscription_view.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_opt_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_info_page/home_info_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/home_page_banner.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/home_page_bottom_section.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/home_rec_view.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebLandingPage extends StatefulWidget {
  const WebLandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  final ScrollController _controller = ScrollController();
  AppController appController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return customScroll(
      _controller,
      SingleChildScrollView(
        controller: _controller,
        child: ResponsiveBuilder(
          builder: (context, si) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Obx(() {
                  return CustomButton(
                    height: 100,
                    width: 300,
                    color: appController.isLoggedIn.value ? red : blue,
                    textColor: appController.isLoggedIn.value ? blue : red,
                    radius: 10,
                    fontName: FontName.bold,
                    fontSize: 20,
                    title:
                        "Change Color ${!(appController.isLoggedIn.value) ? "red" : "blue"}",
                    onTap: () {
                      StoreManager().setLoggedIn(!StoreManager()
                          .isLoggedIn); //setTestBool(!StoreManager().isLoggedIn);
                    },
                  );
                }),

                // CustomButton(
                //   title: "Open",
                //   onTap: () {
                //     Get.dialog(SubscriptionView(
                //       info: TuneInfo(
                //           toneName: "Yone Kyi Yar", albumName: "Diary"),
                //     ));
                //   },
                // ),

                LandingPageBanner(), //ProfileScreen(), //MyTuneScreen(), //
                SizedBox(height: 20),
                homeSearchTopView(),
                SizedBox(height: 20),
                const LandingRecoView(),
                SizedBox(height: si.isMobile ? 10 : 80),
                LandingInfoPage(),
                const LandingPageBottomSection()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget homeSearchTopView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.2),
          child: Container(
              color: blue,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
                child: Center(child: HomeSearchWidget()),
              )),
        );
      },
    );
  }
}
