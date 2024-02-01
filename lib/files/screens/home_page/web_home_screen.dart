import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_info_page/home_info_page.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_music_pack_view/home_music_pack_view.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_page_banner/home_page_banner.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_page_bottom_section/home_page_bottom_section.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/home_rec_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebLandingPage extends StatefulWidget {
  const WebLandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  AppController appController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            const LandingPageBanner(),
            const SizedBox(height: 20),
            homeSearchTopView(),
            const SizedBox(height: 20),
            const LandingRecoView(),
            SizedBox(height: si.isMobile ? 10 : 80),
            const HomeMusicPackView(),
            const LandingInfoPage(),
            const LandingPageBottomSection()
          ],
        );
      },
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
