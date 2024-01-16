import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_image/custom_remote_image.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MyRrbtTuneCell extends StatelessWidget {
  const MyRrbtTuneCell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: red,
      ),
      child: Column(
        children: [
          Flexible(child: tuneImage()),
          tuneInfo(),
          tuneInfo(),
        ],
      ),
    );
  }

  Widget tuneImage() {
    return CustomImage();
  }

  Widget tuneInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: 'title'),
        CustomText(title: 'title'),
      ],
    );
  }
}
