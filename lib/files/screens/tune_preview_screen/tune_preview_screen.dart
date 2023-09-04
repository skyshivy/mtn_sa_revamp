import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_screen.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/widgtes/tune_preview_controls_view.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/widgtes/tune_preview_image.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/widgtes/tune_preview_tune_info.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/widgtes/tune_preview_wishlist_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class TunePreviewScreen extends StatefulWidget {
  final List<TuneInfo> tuneList;
  final int index;

  const TunePreviewScreen(
      {super.key, required this.tuneList, required this.index});
  @override
  State<StatefulWidget> createState() => _TunePreviewScreenState();
}

class _TunePreviewScreenState extends State<TunePreviewScreen> {
  TunePreviewController cont = Get.find();
  @override
  void initState() {
    cont.isLoading.value = true;
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    cont.customInit(widget.tuneList, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return cont.isLoading.value
          ? Center(child: loadingIndicator())
          : Column(
              children: [
                Flexible(flex: 2, child: topSection()),
                Flexible(flex: 3, child: bottomSection())
              ],
            );
    });
  }

  Widget topSection() => tunePreviewImage(cont);
  Widget bottomSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              tunePreviewControls_view(cont),
              tunePreviewTuneInfo(cont),
              buyButtonWidget(),

              //tuneListTuneInfo(widget.tuneList[widget.index])
            ],
          ),
        ),
        tunePreviewWishlistView(),
      ],
    );
  }

  Padding buyButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: CustomButton(
        onTap: () {
          BuyTuneScreen().show(context, cont.list[cont.index.value]);
        },
        textColor: white,
        fontName: FontName.bold,
        fontSize: 14,
        color: blue,
        title: buyStr,
      ),
    );
  }
}
