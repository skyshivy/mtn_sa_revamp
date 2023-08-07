import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_info_page/home_info_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/home_page_banner.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/home_page_bottom_section.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/home_rec_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/web_nav_bar_view.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // CustomTextButton(
          //   title: "Buy",
          //   onTap: () {
          //     BuyTuneScreen().show(context, null);
          //   },
          // ),
          const LandingPageBanner(),
          const LandingRecoView(),
          const SizedBox(height: 80),
          LandingInfoPage(),
          const LandingPageBottomSection()
        ],
      ),
    );
  }
}