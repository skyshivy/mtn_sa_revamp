import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_page_banner/sub_views/banner_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';

class LandingPageBanner extends StatefulWidget {
  const LandingPageBanner({super.key});

  @override
  State<LandingPageBanner> createState() => _LandingPageBannerState();
}

class _LandingPageBannerState extends State<LandingPageBanner> {
  BannerController controller = Get.put(BannerController());
  @override
  void initState() {
    super.initState();

    controller.getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          imageWidget(context),
          controller.isLoading.value ? const SizedBox() : indicator(),
        ],
      );
    });
  }

  Padding indicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: BannerIndicator(),
    );
  }

  Widget imageWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return SizedBox(
          height: width > 700 ? 400 : (width / 2.5),
          child:
              controller.isLoading.value ? loadingIndicator() : corosoulWidget()
          // CustomImage(
          //     index: 8,
          //   ),
          );
    });
  }

  Widget corosoulWidget() {
    return Container(
      color: white,
      width: double.infinity, //currentSize.width,
      height: 200, //currentSize.height,
      child: CarouselSlider(
        options: carousalOptionWidget(),
        items: itemsWidget(),
      ),
    );
  }

  List<Container> itemsWidget() {
    return controller.bannerList.map((banner) {
      return Container(
        child: InkWell(
          hoverColor: transparent,
          onTap: () {
            print("Banner path is ${banner.bannerPath}");
            print("Banner path is ${banner.bannerOrder}");
            String searchKey = banner.searchKey ?? '';
            String type = banner.type ?? '';
            String bannerOrder = banner.bannerOrder ?? '';
            Get.toNamed(bannerTapped, parameters: {
              "searchKey": searchKey,
              "type": type,
              "bannerOrder": bannerOrder
            });
          },
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              color: white,
              child: FadeInImage.assetNetwork(
                placeholder: placeholderImage,
                image: banner.bannerPath ?? logoBigImg,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ]),
        ),
      );
    }).toList();
  }

  CarouselOptions carousalOptionWidget() {
    return CarouselOptions(
      height: 300, //currentSize.height,
      aspectRatio: (Get.width == 600) ? 16 / 9 : 16 / 9,
      viewportFraction: (Get.width == 600) ? 1.0 : 1.0,
      initialPage: 0,
      pauseAutoPlayOnTouch: true,
      enableInfiniteScroll: false,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: false,
      scrollDirection: Axis.horizontal,
      // onScrolled: onScrolledCalled(),
      onPageChanged: onPageChange,
    );
  }

  void onPageChange(int index, CarouselPageChangedReason season) {
    controller.updateSelectedIndex(index);
  }
}
