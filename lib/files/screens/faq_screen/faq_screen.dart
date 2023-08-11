import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/app_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/faq_controller/faq_controller.dart';
import 'package:mtn_sa_revamp/files/controllers/web_tab_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/model/faq_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class FAQScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FAQScreenState();
  }
}

class _FAQScreenState extends State<FAQScreen> {
  late FaqController faqController;

  @override
  void initState() {
    faqController = Get.put(FaqController());
    faqController.getFaqList();
    super.initState();
  }

  @override
  void dispose() {
    print("Disposed ===========");
    Get.delete<FaqController>();
    super.dispose();
  }

  AppController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Obx(() {
        return faqController.isLoading.value ? loadingInd() : faqListView();
      }),
    );
  }

  Widget loadingInd() {
    return Center(child: loadingIndicator());
  }

  Widget faqListView() {
    return ListView.builder(
        itemCount: faqController.list.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                onCellTap(index);
              },
              child: faqCell(faqController.list[index], index));
        });
  }

  void onCellTap(int index) {
    faqController.cellTapped(index);
  }

  Widget faqCell(FaqList info, int index) {
    //var b = faqController.list[0];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: cellDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: questionAnswerWidget(index),
            )),
            plusButtonWidget(info, index)
          ],
        ),
      ),
    );
  }

  Widget questionAnswerWidget(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        questionWidget(index),
        answerWidget(index),
      ],
    );
  }

  Widget questionWidget(int index) {
    var info = faqController.list[index];
    return CustomText(
      title: info.question ?? '',
      fontName: FontName.bold,
      fontSize: 14,
    );
  }

  Widget answerWidget(int index) {
    var info = faqController.list[index];
    return Obx(() {
      return info.isOpen!.value ? answerList(index) : const SizedBox();
    });
  }

  Widget answerList(int index) {
    var info = faqController.list[index];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < (info.answer?.length ?? 0); i++)
          info.answer![i].header!.isEmpty
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: CustomText(
                    title: "${info.answer?[i].header}",
                    fontName: FontName.regular,
                    fontSize: 14,
                  ),
                ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: subAnswer(index),
        )
      ],
    );
  }

  Widget subAnswer(int index) {
    var info = faqController.list[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < (info.answer?.length ?? 0); i++)
          for (int j = 0; j < (info.answer?[i].dataList?.length ?? 0); j++)
            CustomText(
              title: "${info.answer?[i].dataList?[j].data?[0].text}",
              fontName: fontStyle(info
                  .answer?[i].dataList?[j].data?[0].style), //FontName.regular,
              fontSize: 14,
              textColor: textColor(info.answer?[i].dataList?[j].data?[0].style),
            )
      ],
    );
  }

  Widget plusButtonWidget(FaqList info, int index) {
    return Obx(() {
      return CustomButton(
        leftWidget: info.isOpen!.value
            ? const Icon(
                Icons.arrow_drop_down,
                size: 26,
              )
            : const Icon(
                Icons.arrow_right_outlined,
                size: 26,
              ),
      );
    });
  }

  BoxDecoration cellDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: greyLight,
    );
  }

  FontName fontStyle(Style? style) {
    // ignore: unrelated_type_equality_checks
    if (style!.fontWeight == 300) {
      return FontName.regular;
    } else {
      return FontName.bold;
    }
  }

  Color? textColor(Style? style) {
    // ignore: unrelated_type_equality_checks
    if (style!.fontWeight == 300) {
      return greyDark;
    } else {
      return black;
    }
  }
}
