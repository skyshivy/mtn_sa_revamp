import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/my_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';

import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyRrbtTuneListView extends StatelessWidget {
  MyRrbtTuneListView({super.key});
  final MyTuneController cont = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              headerView(si),
              SizedBox(height: si.isMobile ? 5 : 10),
              si.isMobile
                  ? SizedBox(height: 360, child: gridView(si))
                  : gridView(si),
            ],
          ),
        );
      },
    );
  }

  Widget headerView(SizingInformation si) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        title: rrbtStr.tr,
        fontName: FontName.light,
        fontSize: si.isMobile ? 18 : 30,
      ),
    );
  }

  Widget emptyListWidget(SizingInformation si) {
    return SizedBox(
        height: 200,
        child: Center(child: Obx(() {
          return cont.isLoadingPlaying.value
              ? loadingIndicator()
              : CustomText(
                  title: tuneListEmptyStr.tr,
                  fontName: FontName.bold,
                  fontSize: si.isMobile ? 14 : 20,
                );
        })));
  }

  Widget gridView(SizingInformation si) {
    return Obx(() {
      return cont.rrbtTuneList.isEmpty
          ? emptyListWidget(si)
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              scrollDirection: si.isMobile ? Axis.horizontal : Axis.vertical,
              physics:
                  si.isMobile ? null : const NeverScrollableScrollPhysics(),
              itemCount: cont.rrbtTuneList.length,
              gridDelegate: _delegate(si),
              itemBuilder: (context, index) {
                return myTunePlayingCell(
                    cont.rrbtTuneList[index], index, false);
                // MyRrbtTuneCell(
                //   length: "${cont.rrbtTuneList.length}",
                // );
              },
            );
    });
  }
}

SliverGridDelegateWithMaxCrossAxisExtent _delegate(SizingInformation si) {
  return delegate(
    si,
    mainAxisExtent: si.isMobile ? 280 : 400,
    maxCrossAxisExtent: si.isMobile ? 420 : 380,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );
}
