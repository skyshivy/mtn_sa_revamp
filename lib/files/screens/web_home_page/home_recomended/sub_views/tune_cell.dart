import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/positioned_popup.dart';
import 'package:mtn_sa_revamp/files/delete_popover.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/buy_play_button.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/home_more_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/gredient.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeTuneCell extends StatelessWidget {
  final int index;
  final TuneInfo? info;
  final Function()? onTap;
  const HomeTuneCell({super.key, required this.index, this.info, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: decoration(),
        child: mainList(),
      ),
    );
  }

  Column mainList() {
    return Column(
      children: [
        Expanded(flex: 7, child: tuneImageWidget(index)),
        Expanded(flex: 6, child: bottomSection(index)),
      ],
    );
  }

  Widget tuneImageWidget(int index) {
    return Stack(
      children: [
        CustomImage(
          url: info?.toneIdpreviewImageUrl ?? info?.previewImageUrl,
          index: index,
          gradient: customGredient(blackGredient, blackGredient),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: likeAndMoreWidget(),
        ),
      ],
    );
  }

  Widget likeAndMoreWidget() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return si.isMobile
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  likeButton(),
                  moreButton(),
                ],
              );
      },
    );
  }

  Widget likeButton() {
    return (info?.likeCount == null)
        ? const SizedBox()
        : CustomButton(
            height: 30,
            color: Colors.white38,
            leftWidget: likeImage(),
            title: info?.likeCount ?? '0',
            titlePadding: const EdgeInsets.only(right: 8, left: 4),
            fontSize: 16,
            fontName: FontName.medium,
            textColor: white,
            onTap: () {
              print("likeButton tapped");
            },
          );
  }

  Padding likeImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Image.asset(
        likeImg,
        height: 15,
        width: 15,
      ),
    );
  }

  Widget moreButton() {
    return HomeMoreButton(info: info);
  }

  BoxDecoration decoration() {
    return BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: cellShadowColor,
            spreadRadius: 2,
            blurRadius: 2,
          )
        ]);
  }

  Widget bottomSection(int index) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: HomeCellTitleSubTilte(
                info: info,
                titleFontSize: si.isMobile ? 14 : null,
                subTitleFontSize: si.isMobile ? 12 : null,
              )),
              Flexible(
                child: BuyAndPlayButton(
                  info: info,
                  index: index,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
