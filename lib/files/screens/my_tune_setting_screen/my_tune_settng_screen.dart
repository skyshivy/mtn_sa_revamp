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
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<TuneSettingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (contex, si) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: si.isMobile ? 12 : 80, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topTitleWidget(),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  _leftWidget(),
                  const SizedBox(width: 30),
                  Flexible(child: _rightWidget()),
                  const SizedBox(width: 120),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _leftWidget() {
    return tuneSettingImage();
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
        fontName: FontName.regular,
        fontSize: 25,
      ),
    );
  }
}
