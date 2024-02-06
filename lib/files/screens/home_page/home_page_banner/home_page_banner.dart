import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';

import 'package:mtn_sa_revamp/files/screens/home_page/home_page_banner/sub_views/banner_indicator.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

// class LandingPageBanner extends StatefulWidget {
//   const LandingPageBanner({
//     super.key,
//   });

//   @override
//   State<LandingPageBanner> createState() => _LandingPageBannerState();
// }

class LandingPageBanner extends StatelessWidget {
  final BannerController controller = Get.find();
  final CarouselController carouselController = CarouselController();

  LandingPageBanner({super.key});

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
      child: BannerIndicator(tapIndex: (index) {
        carouselController.animateToPage(index);
        printCustom("Tapped index is $index");
      }),
    );
  }

  Widget imageWidget(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return SizedBox(
          height: width > 700 ? (width / 3.5) : (width / 2.5),
          child: controller.isLoading.value
              ? loadingIndicator()
              : corosoulWidget(context)
          // CustomImage(
          //     index: 8,
          //   ),
          );
    });
  }

  Widget corosoulWidget(BuildContext context) {
    return Container(
      color: white,
      width: double.infinity, //currentSize.width,
      height: 200, //currentSize.height,
      child: CarouselSlider(
        carouselController: carouselController,
        options: carousalOptionWidget(),
        items: itemsWidget(context),
      ),
    );
  }

  List<InkWell> itemsWidget(BuildContext context) {
    return controller.bannerList.map((banner) {
      return InkWell(
        hoverColor: transparent,
        onTap: () {
          printCustom("Banner path is ${banner.bannerPath}");
          printCustom("Banner searchKey ${banner.searchKey}");
          printCustom("Banner type ${banner.type}");
          printCustom("Banner bannerOrder ${banner.bannerOrder}");
          String searchKey = banner.searchKey ?? '';
          String type = banner.type ?? '';
          String bannerOrder = banner.bannerOrder ?? '';
          context.goNamed(
            bannerGoRoute,
            queryParameters: {
              'searchKey': searchKey,
              'type': type,
              'bannerOrder': bannerOrder
            },
          );
          // Get.toNamed(bannerTapped, parameters: {
          //   "searchKey": searchKey,
          //   "type": type,
          //   "bannerOrder": bannerOrder
          // });
        },
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
              color: white,
              child: customImage(url: banner.bannerPath ?? logoBigImg)
              // FadeInImage.assetNetwork(
              //   placeholder: placeholderImage,
              //   image: banner.bannerPath ?? logoBigImg,
              //   fit: BoxFit.fill,
              //   height: double.infinity,
              //   width: double.infinity,
              //   imageErrorBuilder: (context, error, stackTrace) {
              //     return Image.asset(
              //       defaultTuneImagePng,
              //       width: double.infinity,
              //       fit: BoxFit.cover,
              //     );
              //   },
              // ),
              ),
        ]),
      );
    }).toList();
  }

  CarouselOptions carousalOptionWidget() {
    return CarouselOptions(
      //height: 400, //currentSize.height,
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
