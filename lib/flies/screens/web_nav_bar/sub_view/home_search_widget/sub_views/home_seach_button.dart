import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

import '../../../../../custom_files/custom_buttons/custom_button.dart';

class HomeSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        color: white,
        width: 47,
        leftWidget: const Icon(
          Icons.search,
          color: yellow,
        ),
        onTap: () {
          print("HomeSearchButton");
        },
      ),
    );
  }
}
