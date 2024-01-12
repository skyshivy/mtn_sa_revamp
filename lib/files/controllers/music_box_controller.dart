import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/music_box_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MusicPackController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isloading = false.obs;
  RxList<MusicBoxSearchList> list = <MusicBoxSearchList>[].obs;
  @override
  void onInit() {
    getMusicBox();
    super.onInit();
  }

  Future<MusicBoxModel> getMusicBox() async {
    String url = '';

    if (kDebugMode) {
      print("debug mode api called in MusicPackController");
      url = 'https://mocki.io/v1/5a415b89-7579-49bc-936d-8b61f818638e';
    } else {
      url =
          '${getMusicBoxUrl}language=English&pageNo=0&perPageCount=20&type=MB';
    }
    isloading.value = true;

    Map<String, dynamic>? map = await ServiceCall().get(url);
    isloading.value = false;
    if (map != null) {
      MusicBoxModel model = MusicBoxModel.fromJson(map);
      list.value = model.responseMap?.musicBoxSearchList ?? [];
      return model;
    } else {
      return MusicBoxModel();
    }
  }
}
