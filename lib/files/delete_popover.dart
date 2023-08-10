import 'package:flutter/material.dart';
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

class MoreButton extends StatelessWidget {
  final Widget icon;

  const MoreButton({super.key, required this.icon});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
      initialValue: 0,
      child: icon,
      itemBuilder: (context) {
        return List.generate(3, (index) {
          return PopupMenuItem(
            value: index,
            child: Text(' no $index'),
          );
        });
      },
    );
  }
}
