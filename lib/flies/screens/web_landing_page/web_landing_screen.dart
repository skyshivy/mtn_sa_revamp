import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_info_page/landing_info_page.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_page_banner/landing_page_banner.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_page_bottom_section/landing_page_bottom_section.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/landing_rec_view.dart';
import 'package:mtn_sa_revamp/flies/screens/web_nav_bar/web_nav_bar_view.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            WebNavBarView(),
            const LandingPageBanner(),
            LandingRecoView(),
            const SizedBox(height: 80),
            LandingInfoPage(),
            const LandingPageBottomSection()
          ],
        ),
      ],
    );
  }
}
