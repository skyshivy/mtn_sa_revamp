import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_active_status.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_image.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_mobile_number.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_prefrence.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_subscribe_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_user_name.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  @override
  void initState() {
    profileController = Get.put(ProfileController());
    profileController.getProfileDetail();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 35),
      child: Obx(
        () {
          return profileController.isLoading.value ? loadInd() : rowWidget();
        },
      ),
    );
  }

  Widget loadInd() {
    return loadingIndicator();
  }

  Widget rowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leftWidget(),
        SizedBox(width: 60),
        Expanded(child: rightWidget()),
      ],
    );
  }

  Widget leftWidget() {
    return Column(
      children: [
        profileImageWidget(),
        const SizedBox(height: 20),
        profileActiveStatus(),
        const SizedBox(height: 20),
        profileSubscribeButtonWidget(() => null),
      ],
    );
  }

  Widget rightWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: profileUserName()),
            SizedBox(width: 30),
            Flexible(child: profileMobileNumberWidget())
          ],
        ),
        SizedBox(height: 35),
        Expanded(child: profilePreferenceWidget())
      ],
    );
  }
}
