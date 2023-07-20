import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/screens/web_nav_bar/sub_view/home_search_widget/sub_views/home_seach_button.dart';
import 'package:mtn_sa_revamp/flies/screens/web_nav_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/flies/utility/colors.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: borderWidget(),
    );
  }

  Widget borderWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 50,
      width: 50,
      decoration: decoration(),
      child: Row(
        children: [
          Expanded(child: HomeSearchTextField()),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: HomeSearchButton(),
          ),
        ],
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      border: border(),
      borderRadius: BorderRadius.circular(25),
    );
  }

  Border border() {
    return Border.all(color: white);
  }
}
