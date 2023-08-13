import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_header_view.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_list_widgets/my_tune_list_widgets/tune_list_cell.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class MyTuneListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myTuneListHeaderView(),
        const SizedBox(height: 40),
        gridView(),
      ],
    );
  }

  Widget gridView() {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      gridDelegate: delegate(mainAxisExtent: 260, maxCrossAxisExtent: 300),
      itemBuilder: (context, index) {
        return tuneListCell();
      },
    );
  }
}
