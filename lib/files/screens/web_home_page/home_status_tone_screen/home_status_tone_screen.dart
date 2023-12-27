import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/home_status_tone_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeStatusToneScreen extends StatefulWidget {
  const HomeStatusToneScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeStatusToneScreen();
}

class _HomeStatusToneScreen extends State<HomeStatusToneScreen> {
  late HomeStatusToneController statusCont;
  @override
  void initState() {
    statusCont = Get.find();
    makeApiCall();
    super.initState();
  }

  makeApiCall() async {
    await Future.delayed(const Duration(milliseconds: 300));
    statusCont.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return statusCont.isLoading.value ? loadingIndi() : checkEmptyList();
      }),
    );
  }

  Widget loadingIndi() {
    return SizedBox(height: 200, child: Center(child: loadingIndicator()));
  }

  Widget checkEmptyList() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(si),
            const SizedBox(height: 8),
            Obx(() {
              return statusCont.message.isNotEmpty
                  ? CustomText(title: statusCont.message.value)
                  : gridViewBuilder(si);
            }),
            seeMoreWidget(si),
          ],
        );
      },
    );
  }

  Widget seeMoreWidget(SizingInformation si) {
    return Obx(() {
      return Visibility(
        visible: statusCont.tuneList.length > 8,
        child: CustomButton(
          title: seeMoreStr.tr,
          fontName: FontName.aheavy,
          fontSize: si.isMobile ? 12 : 18,
          onTap: () {
            List<TuneInfo>? list = statusCont.tuneList;
            print("List is $list");
            context.pushNamed(moreStatusTuneGoRoute,
                extra: list, queryParameters: {'': statusTuneStr.tr});
            print("See more tapped");
          },
        ),
      );
    });
  }

  Widget header(SizingInformation si) {
    return CustomText(
      title: statusTuneStr,
      fontName: FontName.aheavy,
      fontSize: si.isMobile ? 18 : 25,
    );
  }

  Widget gridViewBuilder(SizingInformation si) {
    return GridView.builder(
      itemCount:
          statusCont.tuneList.length > 8 ? 8 : statusCont.tuneList.length,
      shrinkWrap: true,
      gridDelegate: delegate(si),
      itemBuilder: (context, index) {
        return HomeTuneCell(
          info: statusCont.tuneList[index],
          index: index,
          onTap: () {
            print("Tapped index");
            si.isMobile
                ? pushToTunePreView(context, statusCont.tuneList, index)
                : Null;
          },
        );
      },
    );
  }
}
