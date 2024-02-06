import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/music_box_content_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MusicBoxDetailController extends GetxController {
  RxList<TuneInfo> list = <TuneInfo>[].obs;
  RxBool isloading = false.obs;
  getMusicBoxContent(String toneCode, String type) async {
    String url = '';

    // if (kDebugMode) {
    //   printCustom("debug mode api called in MusicBoxDetailController");
    //   url = 'https://mocki.io/v1/31f25e71-141c-4a6f-8679-ed4a6fc5056b';
    //   //'http://10.84.75.129:3445/apigw/Middleware/api/adapter/v1/crbt/music-box-contents?language=English&pageNo=0&perPageCount=20&type=$type&toneCode=$toneCode';
    // } else {
    url =
        '${getMusicBoxContentUrl}language=English&pageNo=0&perPageCount=20&type=$type&toneCode=$toneCode';
    //}
    isloading.value = true;
    Map<String, dynamic>? map;
    // if (kDebugMode) {
    //   await Future.delayed(const Duration(seconds: 2));
    //   map = json.decode(_json);
    // } else {
    map = await ServiceCall().get(url);
    //}

    isloading.value = false;

    printCustom("Map $map");
    if (map != null) {
      MusicBoxContentModel mode = MusicBoxContentModel.fromJson(map);
      if (mode.statusCode == "SC0000") {
        list.value = mode.responseMap?.searchList ?? [];
      }
    }
  }
}

String _json =
    """{"responseMap":{"searchList":[{"toneId":"5553477","toneName":"Pyan Lar Chein Lay","previewImageUrl":"https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId\u003dCDyD3wDbT9k\u003d","toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOJa9GS6n2VEM4ni0r78VjZ4jCEaAxuD8ScWO6xBDmf2ZHT1IFrrsYc4zumIkwYDABA\u003d\u003d","artistName":"Myo Gyi","categoryId":41},{"toneId":"5553562","toneName":"Min Shi Tae Myoh","previewImageUrl":"https://funtone.ooredoo.com.mm/stream-media/get-preview-image?fileId\u003dCDyD3wDbT9k\u003d","toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOJa9GS6n2VEM4ni0r78VjZ7vZC00bMKwv3nQLgBSG++uJe/TYhxbKH0zumIkwYDABA\u003d\u003d","artistName":"Myo Gyi","categoryId":41},{"toneId":"5553651","toneName":"Myit Tar Tayar","previewImageUrl":"http://10.84.75.128:9000/stream-media/get-preview-image?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOJa9GS6n2VEMCmM2Ef0gMvx5oTigfJlg06sYCJj5a0jrcpZvj1StHFEeWFhuxW2/3Y2NrPQA2LXegI7UMnEiS3M\u003d","toneUrl":"http://10.84.75.128:9000/stream-media/get-tone-path?fileId\u003dY7z3CuJFgvvXXw3HzbvBhRADARCeQHW1P8gzE2ZlQy0ugp0/kVFhOJa9GS6n2VEM4ni0r78VjZ7Ob8+QOefqUj8JE6wPu6L08HUMETOZJaAzumIkwYDABA\u003d\u003d","artistName":"Myo Gyi","categoryId":41}]},"message":"Success","respTime":"Jan 11, 2024 1:38:38 PM","statusCode":"SC0000"}""";
