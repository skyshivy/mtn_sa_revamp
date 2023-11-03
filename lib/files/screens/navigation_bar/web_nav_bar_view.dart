import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/text_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_about_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_faq_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_login_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_logo_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/my_tune_button.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/web_nav_my_account.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/web_nav_top_view.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebNavBarView extends StatelessWidget {
  final AppController appController = Get.find();
  final StatefulNavigationShell navigationShell;

  WebNavBarView({super.key, required this.navigationShell});
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      children: [
        const WebNavTopView(),
        bottomSectionWidget(context),
      ],
    );
  }

  Widget bottomSectionWidget(BuildContext context) {
    return Container(
      height: 50,
      decoration: decorationBottomSection(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomLeftWidget(context),
          bottomRightWidget(),
        ],
      ),
    );
  }

  BoxDecoration decorationBottomSection() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          darkGreen,
          lightGreen,
        ],
      ),
    );
  }

  Widget bottomLeftWidget(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Row(
          children: [
            leftSpacing(),

            _homeLogoButton(),
            leftSpacing(),
            seperator(),

            //leftSpacing(width: 20),
            _tuneNavButton(si, context),
            //leftSpacing(),
            seperator(),
            leftSpacing(),
            salatiButton(context),

            leftSpacing(),
            //diyButton(context),
            // HomefaqButton(
            //   onTap: () {
            //     _onTap(1);
            //   },
            // ),
          ],
        );
      },
    );
  }

  Widget _tuneNavButton(SizingInformation si, BuildContext context) {
    return CustomOnHover(
      builder: (isHovered) {
        return Container(
          height: 180,
          color: isHovered ? red : transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: HomeMyTuneButton(
              onTap: (category) {
                print("Tapped === ${category.categoryName}");
                Map<String, dynamic> map = {
                  "categoryName": category.categoryName ?? '',
                  "categoryId": category.categoryId ?? ''
                };
                print("Map is ========$map");
                if (si.isMobile) {
                  context.pushNamed(tuneGoRoute, queryParameters: map);
                } else {
                  context.goNamed(tuneGoRoute, queryParameters: map);
                }

                //_onTap(2);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _homeLogoButton() {
    return CustomOnHover(
      builder: (isHovered) {
        return HomePageLogoButton(onTap: () {
          _onTap(0);
        });
      },
      hovered: () {
        mainFocusNode.unfocus();
      },
    );
  }

  Widget seperator() {
    return Container(
      height: 50,
      color: white,
      width: 1,
    );
  }

  Widget salatiButton(BuildContext context) {
    return CustomOnHover(
      builder: (isHovered) {
        return CustomButton(
          title: salatiStr,
          textColor: white,
          fontName: FontName.ztbold,
          fontSize: 18,
          onTap: () {
            context.goNamed(salatiGoRoute);
            print("salati tapped");
          },
        );
      },
      hovered: () {
        mainFocusNode.unfocus();
      },
    );
  }

  Widget diyButton(BuildContext context) {
    return CustomButton(
      title: doItYourStr,
      textColor: white,
      fontName: FontName.ztbold,
      fontSize: 16,
      onTap: () {
        context.goNamed(diyGoRoute);
        print("Diy tapped");
      },
    );
  }

  Widget leftSpacing({double width = 20}) {
    return SizedBox(width: width);
  }

  Widget bottomRightWidget() {
    return Row(
      children: [
        HomeSearchWidget(),
        leftSpacing(),
        Obx(() {
          return appController.isLoggedIn.value
              ? WebMyAccountButton()
              : HomeLoginButton();
        }),
        leftSpacing(),
      ],
    );
  }

  void _onTap(index) {
    print("Index is =========$index");
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  navDecoration() {}
}
