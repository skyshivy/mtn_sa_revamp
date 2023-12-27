import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/reco_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_top_header_view.dart';
import 'package:mtn_sa_revamp/files/custom_files/grid_delegate.dart';
import 'package:mtn_sa_revamp/files/custom_files/load_more_scroll_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/push_to_preview.dart';
import 'package:mtn_sa_revamp/files/screens/web_home_page/home_recomended/sub_views/tune_cell.dart';
import 'package:mtn_sa_revamp/files/service_call/header.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SeeMoreScreen extends StatefulWidget {
  const SeeMoreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  RecoController recCont = Get.find();
  final ScrollController _scrollCont = ScrollController();
  @override
  void initState() {
    CustomScrollController.loadMoreInitialize(_scrollCont, () {
      print("Load more at ${recCont.tabTitle[recCont.selectedIndex.value]}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTopHeaderView(
            title: recCont.tabTitle[recCont.selectedIndex.value]),
        Expanded(
          child: gridView(),
        ),
      ],
    );
  }

  Widget gridView() {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: si.isMobile ? 8 : 30),
          child: GridView.builder(
            controller: _scrollCont,
            itemCount: recCont.displayList?.length,
            gridDelegate: delegate(si),
            itemBuilder: (context, index) {
              return HomeTuneCell(
                index: index,
                info: recCont.displayList?[index],
                onTap: si.isMobile
                    ? () {
                        pushToTunePreView(context, recCont.displayList, index);
                      }
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
