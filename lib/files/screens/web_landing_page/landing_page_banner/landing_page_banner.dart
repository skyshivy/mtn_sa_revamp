import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/screens/web_landing_page/landing_page_banner/sub_views/banner_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';

class LandingPageBanner extends StatelessWidget {
  const LandingPageBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        imageWidget(context),
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

  Widget imageWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: width > 700 ? 400 : (width / 2.5),
        child: const CustomImage(
          index: 8,
        ));
  }
}
