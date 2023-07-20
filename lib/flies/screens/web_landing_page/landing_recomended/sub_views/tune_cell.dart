import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/sub_views/buy_play_button.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/sub_views/home_cell_title_sub_title.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

class HomeTuneCell extends StatelessWidget {
  final int index;

  const HomeTuneCell({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: cellShadowColor,
              spreadRadius: 2,
              blurRadius: 2,
            )
          ]),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: CustomImage(
              index: index,
            ),
          ),
          Expanded(flex: 6, child: bottomSection()),
        ],
      ),
    );
  }

  Widget bottomSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeCellTitleSubTilte(),
          BuyAndPlayButton(),
        ],
      ),
    );
  }
}
