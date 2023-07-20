import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_page_banner/sub_views/banner_indicator.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';
import 'package:mtn_sa_revamp/flies/utility/image_name.dart';

class LandingPageBanner extends StatelessWidget {
  const LandingPageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        imageWidget(),
        indicator(),
      ],
    );
  }

  Padding indicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: BannerIndicator(),
    );
  }

  Widget imageWidget() {
    return const SizedBox(
        height: 300,
        child: CustomImage(
          index: 8,
        ));
  }
}
