import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<void> searchToneIdApi(String toneId, {int pageNo = 0}) async {
  String url =
      "$searchToneIdUrl?language=${StoreManager().language}&toneId=$toneId&pageNo=$pageNo&perPageCount=$pagePerCount";
  // Map<String, dynamic> map = {
  //   'language': StoreManager().language,
  //   'toneId': toneId,
  //   'pageNo': pageNo,
  //   'perPageCount': pagePerCount
  // };
  Map<String, dynamic>? map = await ServiceCall().get(url);
  print("Map is ");
  return;
}
