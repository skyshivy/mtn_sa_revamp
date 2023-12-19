import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/controllers/search_controller/search_tune_controller.dart';

import 'package:mtn_sa_revamp/files/custom_files/custom_load_more_data.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/load_more_scroll_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/go_router/route_name.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/home_search_widget.dart';
import 'package:mtn_sa_revamp/files/screens/navigation_bar/sub_view/home_search_widget/sub_views/home_search_text_field.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_header_tab.dart';
import 'package:mtn_sa_revamp/files/screens/search_screen/search_sub_views/search_text_field.dart';

import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/web_home_screen.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchTuneController controller = Get.find();
  ScrollController tuneScrollCont = ScrollController();

  @override
  void initState() {
    CustomScrollController.loadMoreInitialize(tuneScrollCont, () {
      controller.loadMoreData();
      print("Tune scrolled bottom");
    });
    // CustomScrollController.loadMoreInitialize(artistScrollCont, () {
    //   print("Artist scrolled bottom");
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return Column(
            children: [
              SearchTextField(),
              Container(
                height: 1,
                color: white,
              ),
              //Visibility(visible: !si.isMobile, child: SearchHeader()),
              SeacrhHeaderTab(),

              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
                  child: controller.isTuneSelected.value == 0
                      ? gridView()
                      : artistList(),
                ),
              ),
              //const SizedBox(height: 30),
              loadMoreData()
            ],
          );
        });
      },
    );
  }

  Widget loadMoreData() {
    //controller.loadMoreData();

    return Obx(() {
      return controller.isLoadMore.value
          ? loadingIndicator(radius: 15)
          : const SizedBox();
    });
  }

  Widget artistList() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Obx(() {
          return controller.artistList.isEmpty
              ? emptyWidget(artistListEmptyStr)
              : ListView.builder(
                  controller: tuneScrollCont,
                  itemCount: controller.artistList.length,
                  itemBuilder: (context, index) {
                    return artistCell(index, si);
                  });
        });
      },
    );
  }

  Widget artistCell(int index, SizingInformation si) {
    return InkWell(
      onTap: () {
        if (si.isMobile) {
          context.pushNamed(artistGoRoute, queryParameters: {
            'artist': controller.artistList[index].matchedParam ?? ''
          });
        } else {
          context.goNamed(artistGoRoute, queryParameters: {
            'artist': controller.artistList[index].matchedParam ?? ''
          });
        }

        // Get.toNamed(artistTuneRoute, parameters: {
        //   "artist": controller.artistList[index].matchedParam ?? ''
        // });
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
              fontName: FontName.abook,
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
        return Obx(() {
          return controller.isLoading.value
              ? loading()
              : controller.songList.isEmpty
                  ? emptyWidget(tuneListEmptyStr)
                  : GridView.builder(
                      controller: tuneScrollCont,
                      itemCount: controller.songList.length,
                      shrinkWrap: true,
                      gridDelegate: delegate(si,
                          mainAxisExtent: si.isMobile ? 230 : null),
                      itemBuilder: (context, index) {
                        return homeCell(index, si);
                      });
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
        fontName: FontName.abook,
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
