import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/banner_controller.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class BannerIndicator extends StatelessWidget {
  BannerController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent,
      child: row(),
    );
  }

  Widget row() {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < controller.bannerList.length; i++) ...[
            dotWidget(i)
          ]
        ],
      );
    });
  }

  Widget dotWidget(int index) {
    return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: (controller.selectedIndex.value == index) ? 12 : 10,
          width: (controller.selectedIndex.value == index) ? 12 : 10,
          decoration: decoration(index),
        ));
  }

  BoxDecoration decoration(int index) {
    return BoxDecoration(
      color: (controller.selectedIndex.value == index) ? blueLight : blue,
      shape: BoxShape.circle,
      border: Border.all(color: white),
    );
  }
}
