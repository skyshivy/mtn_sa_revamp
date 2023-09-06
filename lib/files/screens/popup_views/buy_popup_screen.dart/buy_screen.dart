import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_popup_widget.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_msisdn_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text_field/custom_text_field.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class BuyTuneScreen {
  TextEditingController textFieldController = TextEditingController();
  late TuneInfo? info;

  Future<dynamic> show(BuildContext context, TuneInfo? info) {
    this.info = info;
    return showPopup(BuyScreenState(
      info: info,
    ));
  }
}

class BuyScreenState extends StatelessWidget {
  late BuildContext? context;
  final TuneInfo? info;

  BuyScreenState({super.key, this.info});
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: mainContainer(),
    );
  }

  Widget mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      clipBehavior: Clip.hardEdge,
      width: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerWidget(),
          Padding(
            padding: EdgeInsets.all(isPhone(context!) ? 10 : 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageWidget(),
                titleAndTuneChargeRow(),
                buttons(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row titleAndTuneChargeRow() {
    return Row(
      mainAxisAlignment: isPhone(context!)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: isPhone(context!)
                ? MainAxisAlignment.start
                : MainAxisAlignment.start,
            crossAxisAlignment: isPhone(context!)
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              title(),
              SizedBox(height: 20),
              tuneCharge(),
              SizedBox(height: 10),
              numberTextField()
            ],
          ),
        ),
      ],
    );
  }

  Widget numberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: CustomMsisdnTextField(text: "2342"),
    );
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

  CustomButton headerCloseButton() {
    return CustomButton(
      onTap: () {
        Navigator.pop(context!);
      },
      leftWidget: Icon(Icons.close),
    );
  }

  CustomText heaerTitle() {
    return CustomText(
      title: buyTuneStr,
      fontName: fontName(FontName.medium, FontName.bold),
      fontSize: fontSize(18, 20),
    );
  }

  Widget imageWidget() {
    return SizedBox(
      width: isPhone(context!) ? 200 : double.infinity,
      height: isPhone(context!) ? 200 : 200,
      child: remoteImageContainer(info),
    );
  }

  Widget title() {
    return HomeCellTitleSubTilte(
      mainAxisAlignment: isPhone(context!)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: isPhone(context!)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      info: info,
    );
  }

  Widget tuneCharge() {
    return HomeCellTitleSubTilte(
      mainAxisAlignment: isPhone(context!)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: isPhone(context!)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      title: tuneChargeStr,
      subTitle: "10 RAND/MONTH",
      titleFontName: FontName.regular,
      titleFontSize: 16,
      subTitleFontName: FontName.bold,
      subTitleFontSize: 20,
    );
  }

  Widget buttons() {
    //print("Width is ${Get.width}");
    return !isPhone(context!) ? buttonRow() : buttonColumns();
  }

  Column buttonColumns() {
    return Column(
      children: [
        const SizedBox(height: 20),
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
    return CustomButton(
      onTap: () {
        print("Confirm buy button tapped");
      },
      fontName: FontName.bold,
      title: confirmStr,
      color: blue,
      textColor: white,
    );
  }

  Widget cancelButton() {
    return CustomButton(
      onTap: () {
        Navigator.pop(context!);
      },
      fontName: FontName.bold,
      title: cancelStr,
      borderColor: blueLight,
      color: white,
    );
  }
}
