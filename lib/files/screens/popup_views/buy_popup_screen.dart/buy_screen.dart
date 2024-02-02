import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/buy_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/login_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_alert.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_popup_widget.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/subscription_view.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/popup_views/buy_popup_screen.dart/buy_opt_view.dart';
import 'package:mtn_sa_revamp/files/screens/home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BuyTuneScreen {
  TextEditingController textFieldController = TextEditingController();
  late TuneInfo? info;

  BuyTuneScreen();

  Future<dynamic> show(TuneInfo? info, {bool isBuyMusicChannel = false}) {
    this.info = info;
    return showPopup(_BuyScreen(
      info: info,
      isBuyMusicPack: isBuyMusicChannel,
    ));
  }
}

class _BuyScreen extends StatefulWidget {
  final TuneInfo? info;
  final bool isBuyMusicPack;
  const _BuyScreen({super.key, this.info, this.isBuyMusicPack = false});
  @override
  State<StatefulWidget> createState() => _BuyScreenState(info);
}

class _BuyScreenState extends State<_BuyScreen> {
  BuyController buyController = Get.find();
  LoginController loginCont = Get.put(LoginController());
  @override
  void initState() {
    buyController.customInit();
    buyController.isBuyMusicChannel = widget.isBuyMusicPack;
    buyController.getTuneCharge(info ?? TuneInfo());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  late BuildContext context;
  final TuneInfo? info;

  _BuyScreenState(this.info);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() {
        return buyController.isBuySuccess.value
            ? CustomAlertView(
                title: buyController.successMessage.value,
              )
            : buyController.isShowOtpView.value
                ? BuyOtpView()
                : Obx(() {
                    return buyController.isShowSubscriptionPlan.value
                        ? subscriptionView()
                        : mainContainer();
                  });
      }),
    );
  }

  Widget subscriptionView() {
    return SubscriptionView(
      info: widget.info ?? TuneInfo(),
    );
  }

  Widget mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      clipBehavior: Clip.hardEdge,
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerWidget(),
          Padding(
            padding: EdgeInsets.all(isPhone(context) ? 10 : 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageWidget(),
                titleAndTuneChargeRow(),
                upgradeRadioNutton(),
                buttons(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget upgradeRadioNutton() {
    return InkWell(
      onTap: () {
        buyController.isUpgradeSelected.value =
            !buyController.isUpgradeSelected.value;
      },
      child: Obx(() {
        return Visibility(
            visible: !buyController.isHideUpgrade.value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Image.asset(
                      buyController.isUpgradeSelected.value
                          ? radioButtonSelectedImg
                          : radioButtonUnSelectedImg,
                      height: 18,
                    );
                  }),
                  const SizedBox(width: 4),
                  Flexible(
                      child: CustomText(
                    title: upgradeMessageStr.tr,
                    fontName: FontName.bold,
                  ))
                ],
              ),
            ));
      }),
    );
    // Obx(() {
    //   return
    // });
  }

  Row titleAndTuneChargeRow() {
    return Row(
      mainAxisAlignment:
          isPhone(context) ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: isPhone(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: isPhone(context)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              title(),
              const SizedBox(height: 20),
              tuneCharge(),
              const SizedBox(height: 10),
              numberTextField(),
              StoreManager().isLoggedIn
                  ? _msisdnErrorMessage()
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  Widget numberTextField() {
    return Visibility(
      visible: !StoreManager().isLoggedIn,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return CustomMsisdnTextField(
                borderColor: (buyController.msisdn.value.length ==
                        StoreManager().msisdnLength)
                    ? atomCryan
                    : borderColor,
                enabled: !buyController.isVerifying.value,
                text: buyController.msisdn.value,
                onChanged: (p0) {
                  loginCont.msisdn.value = p0;
                  buyController.msisdn.value = p0;
                  buyController.updateMsisdn(p0);
                },
                onSubmit: (p0) {
                  if (buyController.msisdn.value.length <
                      StoreManager().msisdnLength) {
                    buyController.errorMessage.value = enterValidMsisdnStr.tr;
                    return;
                  }
                  validateMsisdnAction(context, widget.info ?? TuneInfo());
                  //buyController.updateMsisdn(p0);
                },
              );
            }),
            _msisdnErrorMessage(),
          ],
        ),
      ),
    );
  }

  void validateMsisdnAction(BuildContext context, TuneInfo info) async {
    if (StoreManager().isLoggedIn) {
      await buyController.getTunePriceAndBuyTune(info,
          isBuyMusicChannel: widget.isBuyMusicPack);
    } else {
      if (buyController.msisdn.value.length < StoreManager().msisdnLength) {
        buyController.errorMessage.value = enterValidMsisdnStr.tr;
        return;
      }
      await buyController.msisdnValidation(info,
          isBuyMusicChannel: widget.isBuyMusicPack);
    }

    printCustom("Confirm buy button tapped 234");
  }

  Widget _msisdnErrorMessage() {
    return Obx(() {
      return Visibility(
          visible: buyController.errorMessage.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CustomText(
              title: buyController.errorMessage.value,
              textColor: red,
            ),
          ));
    });
  }

  Widget headerWidget() {
    return Container(
      height: 50,
      color: grey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPhone(context!) ? 20 : 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            heaerTitle(),
            headerCloseButton(),
          ],
        ),
      ),
    );
  }

  Widget headerCloseButton() {
    return CustomButton(
      onTap: () {
        Navigator.pop(context!);
      },
      leftWidget: Icon(Icons.close),
    );
  }

  Widget heaerTitle() {
    return CustomText(
      title: buyTuneStr.tr,
      fontName: fontName(FontName.medium, FontName.bold),
      fontSize: fontSize(18, 20),
    );
  }

  Widget imageWidget() {
    return SizedBox(
      width: isPhone(context) ? 200 : double.infinity,
      height: isPhone(context) ? 200 : 200,
      child: remoteImageContainer(info),
    );
  }

  Widget title() {
    return HomeCellTitleSubTilte(
      mainAxisAlignment:
          isPhone(context) ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: isPhone(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      info: info,
    );
  }

  Widget tuneCharge() {
    return Obx(() {
      return HomeCellTitleSubTilte(
        mainAxisAlignment: isPhone(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: isPhone(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        title: tuneChargeStr.tr,
        subTitle: buyController.tuneCharge.value,
        titleFontName: FontName.medium,
        titleFontSize: 16,
        subTitleFontName: FontName.bold,
        subTitleFontSize: 20,
      );
    });
  }

  Widget buttons() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return !si.isMobile ? buttonRow() : buttonColumns();
      },
    );
  }

  Column buttonColumns() {
    return Column(
      children: [
        const SizedBox(height: 4),
        cancelButton(),
        const SizedBox(height: 10),
        confirmButton(),
      ],
    );
  }

  Row buttonRow() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: cancelButton(),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: confirmButton(),
        )),
      ],
    );
  }

  Widget confirmButton() {
    return Obx(() {
      return buyController.isVerifying.value
          ? loadingIndicator(radius: 12, height: 40)
          : ResponsiveBuilder(
              builder: (context, si) {
                return CustomButton(
                  onTap: () async {
                    validateMsisdnAction(context, info ?? TuneInfo());
                  },
                  fontName: FontName.bold,
                  title: confirmStr.tr,
                  color: blue,
                  textColor: white,
                );
              },
            );
    });
  }

  Widget cancelButton() {
    return CustomButton(
      onTap: () {
        Navigator.pop(context!);
      },
      fontName: FontName.bold,
      title: cancelStr.tr,
      borderColor: atomCryan,
      color: white,
    );
  }
}
