import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/player_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_preview_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
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
  PlayerController playCont = Get.find();
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
    return Material(
      child: Obx(() {
        return cont.isLoading.value
            ? Center(child: loadingIndicator())
            : Column(
                children: [
                  Flexible(flex: 3, child: topSection()),
                  Flexible(flex: 3, child: bottomSection())
                ],
              );
      }),
    );
  }

  Widget topSection() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: tunePreviewImage(cont),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageTopWidget(),
            Column(
              children: [
                _countDownTimerWidget(),
                slipedWidget(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _countDownTimerWidget() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: textShadow(),
              child: CustomText(
                title: playCont.currentSeekingStr.value,
                textColor: white,
              ),
            ),
            Container(
              decoration: textShadow(),
              child: CustomText(
                title: playCont.maxDurationStr.value,
                textColor: white,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget imageTopWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_previewTextWidget(), _closeButtonWidgte()],
        ),
      ),
    );
  }

  CustomButton _closeButtonWidgte() {
    return CustomButton(
      width: 40,
      color: black.withOpacity(0.4),
      onTap: () {
        cont.stopPlayer();
        Navigator.pop(context);
      },
      leftWidget: const Icon(
        Icons.close,
        color: white,
      ),
    );
  }

  Container _previewTextWidget() {
    return Container(
      decoration: textShadow(),
      child: const CustomText(
          title: previewTuneStr, fontName: FontName.aheavy, textColor: white),
    );
  }

  BoxDecoration textShadow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(color: black.withOpacity(0.5), blurRadius: 18, spreadRadius: 0)
    ]);
  }

  Widget slipedWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Obx(() {
        return SliderTheme(
            data: SliderThemeData(
              trackShape: CustomTrackShape(),
            ),
            child: Slider(
                min: 0,
                max: playCont.maxDuration.value.toDouble(),
                value: playCont.current.value.toDouble(),
                activeColor: darkGreen,
                inactiveColor: lightGreen,
                onChanged: (value) {
                  playCont.seekTo(Duration(seconds: value.toInt()));
                  print("value changed ${value.seconds}");
                }));
      }),
    );
  }

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
        tunePreviewWishlistView(cont, playCont),
      ],
    );
  }

  Padding buyButtonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: CustomButton(
        onTap: () {
          cont.stopPlayer();
          BuyTuneScreen().show(context, cont.list[cont.index.value]);
        },
        textColor: white,
        fontName: FontName.aheavy,
        fontSize: 14,
        color: darkGreen,
        title: buyStr,
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
