import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header_tab.dart';

import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/utility/route_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  SearchTuneController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
            child: Obx(() {
              return Column(
                children: [
                  SearchHeader(),
                  SeacrhHeaderTab(),
                  const SizedBox(height: 20),
                  Expanded(
                      child: controller.isTuneSelected.value == 0
                          ? gridView()
                          : artistList()),
                  //const SizedBox(height: 30),
                  loadMoreData()
                ],
              );
            }));
      },
    );
  }

  Widget loadMoreData() {
    return loadMoreDataButton(
        isLoading: controller.isLoadMore.value,
        rightAction: () {
          controller.loadMoreData();
        });
  }

  Widget artistList() {
    return controller.artistList.isEmpty
        ? emptyWidget(artistListEmptyStr)
        : ListView.builder(
            itemCount: controller.artistList.length,
            itemBuilder: (context, index) {
              return artistCell(index);
            });
  }

  Widget artistCell(int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(artistTuneRoute, parameters: {
          "artist": controller.artistList[index].matchedParam ?? ''
        });
        print(
            "Tapped artist is ${controller.artistList[index].matchedParam ?? ''}");
      },
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: (controller.artistList[index].matchedParam ?? '')
                  .toUpperCase(),
              fontName: FontName.medium,
              fontSize: 16,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return controller.isLoading.value
            ? loading()
            : controller.songList.isEmpty
                ? emptyWidget(tuneListEmptyStr)
                : GridView.builder(
                    itemCount: controller.songList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        delegate(si, mainAxisExtent: si.isMobile ? 230 : null),
                    itemBuilder: (context, index) {
                      return homeCell(index, si);
                    });
      },
    );
  }

  Widget loading() =>
      Center(child: SizedBox(height: 300, child: loadingIndicator()));

  Widget emptyWidget(String title) {
    return Center(
      child: CustomText(
        title: controller.isLoaded.value ? title : searchTuneStr,
        fontName: FontName.medium,
        fontSize: 16,
      ),
    );
  }

  HomeTuneCell homeCell(int index, SizingInformation si) {
    return HomeTuneCell(
      info: controller.songList[index],
      index: index,
      onTap: si.isMobile
          ? () {
              pushToTunePreView(context, controller.songList, index);
            }
          : null,
    );
  }
}
