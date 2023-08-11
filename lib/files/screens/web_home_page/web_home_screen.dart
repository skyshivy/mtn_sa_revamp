import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_info_page/home_info_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/home_page_banner.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/home_page_bottom_section.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/home_rec_view.dart';

class WebLandingPage extends StatelessWidget {
  WebLandingPage({super.key});
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return customScroll(
        SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              const LandingPageBanner(),
              const LandingRecoView(),
              const SizedBox(height: 80),
              LandingInfoPage(),
              const LandingPageBottomSection()
            ],
          ),
        ),
        _controller);
  }
}
