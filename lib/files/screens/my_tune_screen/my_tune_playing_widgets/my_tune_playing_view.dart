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
        const SizedBox(height: 30),
        gridView(),
      ],
    );
  }

  Widget gridView() {
    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: _delegate(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: myTunePlayingCell(),
        );
      },
    );
  }

  SliverGridDelegateWithMaxCrossAxisExtent _delegate() {
    return delegate(
      mainAxisExtent: 400,
      maxCrossAxisExtent: 320,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    );
  }
}
