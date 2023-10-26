import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_gredient.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_scroll_by_key.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/subscription_view.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_settng_screen.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_opt_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_category/home_category_view.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_info_page/home_info_page.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/home_page_banner.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_bottom_section/home_page_bottom_section.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/home_rec_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebLandingPage extends StatelessWidget {
  WebLandingPage({super.key});
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return customScroll(
      SingleChildScrollView(
        controller: _controller,
        child: ResponsiveBuilder(
          builder: (context, si) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeSearchTopView(),
                const LandingPageBanner(), //ProfileScreen(), //MyTuneScreen(), //
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const LandingRecoView(),
                      SizedBox(height: si.isMobile ? 10 : 20),
                      //LandingInfoPage(),

                      HomeCategoryView(),
                      SizedBox(height: si.isMobile ? 10 : 30),
                    ],
                  ),
                ),
                const LandingPageBottomSection()
              ],
            );
          },
        ),
      ),
      _controller,
    );
  }

  Widget homeSearchTopView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Visibility(
          visible: si.isMobile,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.2),
            child: Container(
                decoration: BoxDecoration(gradient: customGredient()),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(child: HomeSearchWidget()),
                )),
          ),
        );
      },
    );
  }
}
