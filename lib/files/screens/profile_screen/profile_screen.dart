import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/profile_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_active_status.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_cancel_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_edit_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_image.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_mobile_number.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_prefrence.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_reverse_rbt_status.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_subscribe_button.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_crbt_tune_status.dart';
import 'package:mtn_sa_revamp/files/screens/profile_screen/widgtes/profile_user_name.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
    profileController = Get.find();
    profileController.getProfileDetail();
    print("init profile page");
    super.initState();
  }

  @override
  void dispose() {
    print("deinit profile page");
    Get.delete<ProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        si = sizingInformation;
        return Obx(
          () {
            return profileController.isLoading.value
                ? loadInd()
                : SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: si.isMobile ? 20 : 60,
                        vertical: si.isMobile ? 8 : 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        updatingPageLoadingIndicator(),
                        SizedBox(height: si.isMobile ? 20 : 50),
                        rowWidget(si, profileController),
                        SizedBox(height: si.isMobile ? 20 : 50),
                      ],
                    ),
                  ));
          },
        );
      },
    );
  }

  Widget updatingPageLoadingIndicator() {
    return Obx(() {
      return Visibility(
          visible: profileController.updatingProfilePage.value,
          child: ResponsiveBuilder(
            builder: (context, si) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: loadingIndicator(radius: si.isMobile ? 15 : 20),
              );
            },
          ));
    });
  }

  Widget loadInd() {
    return Center(child: loadingIndicator());
  }

  Widget rowWidget(SizingInformation si, ProfileController controller) {
    return si.isMobile
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              leftWidget(si),
              const SizedBox(height: 10),
              Flexible(child: rightWidget(si, controller)),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomButton(
              //   title: "changeToken",
              //   onTap: () {
              //     StoreManager().accessToken = '3r5345werrwerewr';
              //     StoreManager().setAccessToken("eer4rewtewrewtet");
              //   },
              // ),
              leftWidget(si),
              const SizedBox(width: 60),
              Flexible(child: rightWidget(si, controller)),
            ],
          );
  }

  Widget leftWidget(SizingInformation si) {
    return Column(
      children: [
        profileImageWidget(),
        const SizedBox(height: 30),
        profileActiveStatus(),
        //const SizedBox(height: 20),
        //profileSubscribeButtonWidget(si, () => null),
      ],
    );
  }

  Widget rightWidget(SizingInformation si, ProfileController controller) {
    return Column(
      mainAxisAlignment:
          si.isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        userDetailWidget(si),
        inCaseOfBothCardHidden(si),
        const SizedBox(height: 25),
        statusWidgets(),
        const SizedBox(height: 20),
// uncomment below line to show prefrences
        //Flexible(child: profilePreferenceWidget(si, controller)),
        profileCancelEditButton(si),
      ],
    );
  }

  Widget inCaseOfBothCardHidden(SizingInformation si) {
    return Obx(() {
      return profileController.isBothStatusHidden.value
          ? Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4), color: grey),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: si.isMobile ? 20 : 30),
                    child: CustomText(
                      title: notSubscribedToAnyService,
                      alignment: TextAlign.center,
                      fontName: FontName.medium,
                      fontSize: si.isMobile ? 13 : 16,
                    ),
                  ))),
            )
          : SizedBox();
      // Visibility(
      //   visible: profileController.isBothStatusHidden.value,
      //   child:
      // );
    });
  }

  Widget statusWidgets() {
    return Wrap(
      runSpacing: 10,
      children: [
        ProfileCrbtTuneStatus(),
        SizedBox(width: 20),
        ProfileReverseRbtStatus(),
      ],
    );
  }

  Widget userDetailWidget(SizingInformation si) {
    return si.isMobile ? _mobileUserDetailColumn(si) : desktopUserDetailRow(si);
  }

  Row desktopUserDetailRow(SizingInformation si) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: profileUserName(si)),
        const SizedBox(width: 30),
        Flexible(child: profileMobileNumberWidget(si))
      ],
    );
  }

  Column _mobileUserDetailColumn(SizingInformation si) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 28),
        profileUserName(si),
        const SizedBox(height: 28),
        profileMobileNumberWidget(si),
      ],
    );
  }

  Widget profileCancelEditButton(SizingInformation si) {
    ProfileController controller = Get.find();
    return si.isMobile
        ? _mobileEditAndCancelButtonColunm(controller)
        : _desktopRowCancelAndEditButton(si, controller);
  }

  Row _desktopRowCancelAndEditButton(
      SizingInformation si, ProfileController controller) {
    return Row(
      mainAxisAlignment:
          si.isMobile ? MainAxisAlignment.center : MainAxisAlignment.end,
      crossAxisAlignment:
          si.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        Visibility(
            visible: controller.editEnable.value,
            child: SizedBox(width: 140, child: profileCancelButton())),
        const SizedBox(width: 20),
        SizedBox(width: 140, child: profileEditButton())
      ],
    );
  }

  Padding _mobileEditAndCancelButtonColunm(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Visibility(
              visible: controller.editEnable.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: profileCancelButton(),
              )),
          profileEditButton()
        ],
      ),
    );
  }
}
