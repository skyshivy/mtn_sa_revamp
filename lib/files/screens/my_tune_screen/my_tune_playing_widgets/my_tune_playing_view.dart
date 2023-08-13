import 'package:flutter/cupertino.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/my_tune_playing_cell.dart';
import 'package:mtn_sa_revamp/files/screens/my_tune_screen/my_tune_playing_widgets/playing_widgets/playing_tune_header.dart';

class MyTunePlayingView extends StatelessWidget {
  const MyTunePlayingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myTuneplayingHeaderView(),
        const SizedBox(height: 10),
        Expanded(child: gridView()),
      ],
    );
  }

  Widget gridView() {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      gridDelegate: delegate(
          mainAxisExtent: 420,
          maxCrossAxisExtent: 300,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: myTunePlayingCell(),
        );
      },
    );
  }
}
