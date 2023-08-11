import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/artist_controller.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';

class ArtistTuneScreen extends StatefulWidget {
  final String artistName;
  const ArtistTuneScreen({super.key, required this.artistName});

  @override
  State<ArtistTuneScreen> createState() => _ArtistTuneScreenState();
}

class _ArtistTuneScreenState extends State<ArtistTuneScreen> {
  ArtistController controller = Get.put(ArtistController());

  @override
  void initState() {
    controller.getArtistSongs(widget.artistName);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          CustomTopHeaderView(title: widget.artistName),
          controller.isLaoding.value
              ? Expanded(child: loadingIndicator())
              : Expanded(child: gridView()),
          loadMoreData()
        ],
      );
    });
  }

  Widget loadMoreData() {
    return loadMoreDataButton(
      isLoading: controller.isLoadMore.value,
      rightAction: () {
        controller.loadMoreData();
      },
    );
  }

  GridView gridView() {
    return GridView.builder(
        primary: true,
        itemCount: controller.searchList.length,
        gridDelegate: delegate(),
        itemBuilder: (context, index) {
          return HomeTuneCell(
            index: index,
            info: controller.searchList[index],
          );
        });
  }
}
