import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/screens/web_nav_bar/web_nav_bar_view.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

class WebLandingPage extends StatelessWidget {
  const WebLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WebNavBarView(),
        Container(
          color: white,
        ),
      ],
    );
  }
}
