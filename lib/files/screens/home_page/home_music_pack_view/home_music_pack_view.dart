import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/music_box_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_music_pack_view/widgtes/music_pack_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeMusicPackView extends StatefulWidget {
  const HomeMusicPackView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeMusicPackViewState();
}

class _HomeMusicPackViewState extends State<HomeMusicPackView> {
  final List<String> imgList = [musicBox1Img, musicBox2Img, musicBox3Img];
  final List<String> infoList = [
    musicPackInfo1,
    musicPackInfo2,
    musicPackInfo3
  ];
  var scroll = ScrollController();
  MusicPackController cont = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //Get.delete<MusicPackController>();
    super.dispose();
  }

  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          carouselSlider(),
          indicator(),
        ],
      ),
    );
  }

  Widget indicator() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: scroll,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Obx(() {
                return CustomButton(
                  borderColor: white,
                  onTap: () {
                    carouselController.animateToPage(index);

                    cont.selectedIndex.value = index;
                  },
                  radius: 6,
                  color: cont.selectedIndex.value == index ? atomCryan : blue,
                  height: 12,
                  width: 12,
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget carouselSlider() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return CarouselSlider(
            carouselController: carouselController,
            options: carousalOptionWidget(si),
            items: [
              for (int i = 0; i < imgList.length; i++)
                musicPackCell(imgList[i], infoList[i], i),
            ]);
      },
    );
  }

// itemsWidget(int index){
//   return cont.map((i,e){
//     return musicPackCell("img", "info", index);
//   });
//}
  CarouselOptions carousalOptionWidget(SizingInformation si) {
    return CarouselOptions(
      height: si.isMobile ? 600 : 500, //currentSize.height,
      aspectRatio: 16 / 4, //(Get.width == 600) ? 16 / 9 : 16 / 9,
      viewportFraction: 1,
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
    //printCustom("index tapped $index");
    cont.selectedIndex.value = index;
    //controller.updateSelectedIndex(index);
  }
}
