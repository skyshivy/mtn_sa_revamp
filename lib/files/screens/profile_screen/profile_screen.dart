import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_active_status.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_cancel_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_edit_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_image.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_mobile_number.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_prefrence.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_subscribe_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_user_name.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController profileController;
  late SizingInformation si;
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
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        si = sizingInformation;
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: si.isMobile ? 8 : 60, vertical: si.isMobile ? 8 : 35),
          child: Obx(
            () {
              return profileController.isLoading.value
                  ? loadInd()
                  : rowWidget();
            },
          ),
        );
      },
    );
  }

  Widget loadInd() {
    return loadingIndicator();
  }

  Widget rowWidget() {
    return si.isMobile
        ? Column(
            children: [
              leftWidget(),
              const SizedBox(height: 20),
              Flexible(child: rightWidget(si)),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftWidget(),
              const SizedBox(width: 60),
              Flexible(child: rightWidget(si)),
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

  Widget rightWidget(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        userDetailWidget(si),
        const SizedBox(height: 35),
        Expanded(child: profilePreferenceWidget()),
        profileCancelEditButton(),
      ],
    );
  }

  Widget userDetailWidget(SizingInformation si) {
    return si.isMobile
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profileUserName(),
              const SizedBox(height: 8),
              profileMobileNumberWidget(),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: profileUserName()),
              const SizedBox(width: 30),
              Flexible(child: profileMobileNumberWidget())
            ],
          );
  }

  Widget profileCancelEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 140, child: profileCancelButton()),
        const SizedBox(width: 20),
        SizedBox(width: 140, child: profileEditButton())
      ],
    );
  }
}
