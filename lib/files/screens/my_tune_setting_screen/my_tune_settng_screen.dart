import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/tune_setting_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_cancel_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_confirm_button.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_image.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_radio_btn_callers_type.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_setting_screen/my_tune_setting_widgets/tune_setting_right_widget.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyTuneSettingScreen extends StatefulWidget {
  final String toneId;
  final String toneName;
  final String toneArtist;
  final String toneImage;

  const MyTuneSettingScreen({
    super.key,
    required this.toneId,
    required this.toneName,
    required this.toneArtist,
    required this.toneImage,
  });
  @override
  State<StatefulWidget> createState() {
    return _MyTuneSettingScreenState();
  }
}

class _MyTuneSettingScreenState extends State<MyTuneSettingScreen> {
  late TuneSettingController controller;

  @override
  void initState() {
    controller = Get.put(TuneSettingController());
    controller.tuneName = widget.toneName;
    controller.tuneArtist = widget.toneArtist;
    controller.tuneId = widget.toneId;
    controller.tuneImage = widget.toneImage;
    _getPackStatus();
    super.initState();
  }

  _getPackStatus() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.getPackName();
  }

  @override
  void dispose() {
    Get.delete<TuneSettingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (contex, si) {
      return Center(
        child: ListView(
          shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: si.isMobile ? 12 : 80, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topTitleWidget(),
                  Wrap(
                    runSpacing: 50,
                    alignment: WrapAlignment.center,
                    children: [
                      _leftWidget(si),
                      const SizedBox(width: 30),
                      _rightWidget(),
                      const SizedBox(width: 120),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _leftWidget(SizingInformation si) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: si.isDesktop ? 0 : 20, top: si.isDesktop ? 0 : 20),
      child: tuneSettingImage(),
    );
  }

  Widget _rightWidget() {
    return SizedBox(
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          tuneSettingRightWidgte(),
          const SizedBox(height: 15),
          tuneSettingConfirmButton(),
        ],
      ),
    );
  }

  Widget topTitleWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: CustomText(
        title: advancedSettingsStr,
        fontName: FontName.medium,
        fontSize: 25,
      ),
    );
  }
}
