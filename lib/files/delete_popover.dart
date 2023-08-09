import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_popup_widget.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:popover/popover.dart';

showPopover1(BuildContext context) {
  showPopover(
      context: context,
      onPop: () => print('Popover was popped!'),
      direction: PopoverDirection.bottom,
      width: 200,
      height: 400,
      arrowHeight: 15,
      arrowWidth: 30,
      bodyBuilder: (context) {
        return Container(
          color: red,
          height: 110,
          width: 200,
        );
      });
}
