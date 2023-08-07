import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_about_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_faq_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_login_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/home_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/my_tune_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_nav_bar/sub_view/web_nav_my_account.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class WebNavBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: leftWidget()),
          Row(children: [rightWidget()]),
        ],
      ),
    );
  }

  Widget leftWidget() {
    return Row(
      children: [
        leftSpacing(),
        HomePageLogoButton(),
        leftSpacing(width: 30),
        HomeMyTuneButton(),
        // leftSpacing(),
        // HomeAboutButton(),
        leftSpacing(),
        HomefaqButton(),
      ],
    );
  }

  Widget leftSpacing({double width = 40}) {
    return SizedBox(width: width);
  }

  Widget rightWidget() {
    return Row(
      children: [
        HomeSearchWidget(),
        leftSpacing(),
        const HomeLoginButton(),
        leftSpacing(),
        webMyAccountButton(),
        leftSpacing(),
      ],
    );
  }
}
