import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/sub_views/home_reco_tab_view.dart';
import 'package:mtn_sa_revamp/flies/screens/web_landing_page/landing_recomended/sub_views/tune_cell.dart';

class LandingRecoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          HomeRecoTabView(),
          gridView(),
        ],
      ),
    );
  }

  Widget gridView() {
    return GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        gridDelegate: delegate(),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return HomeTuneCell(
            index: index,
          );
        });
  }

  SliverGridDelegateWithMaxCrossAxisExtent delegate() {
    return const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 0.911,
        mainAxisExtent: 280,
        maxCrossAxisExtent: 290,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20);
  }
}
