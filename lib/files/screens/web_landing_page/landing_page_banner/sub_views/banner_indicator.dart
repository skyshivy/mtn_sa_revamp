import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class BannerIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent,
      child: row(),
    );
  }

  Row row() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < 5; i++) ...[dotWidget(i)]
      ],
    );
  }

  Widget dotWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: decoration(index),
      ),
    );
  }

  BoxDecoration decoration(int index) {
    return BoxDecoration(
      color: index == 0 ? red : yellow,
      shape: BoxShape.circle,
      border: Border.all(color: white),
    );
  }
}
