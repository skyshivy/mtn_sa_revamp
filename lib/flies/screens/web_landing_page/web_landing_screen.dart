import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_page_banner/landing_page_banner.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/landing_rec_view.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  WebNavBarView(),
        //LandingPageBanner(),
        Expanded(child: LandingRecoView())
      ],
    );
  }
}
