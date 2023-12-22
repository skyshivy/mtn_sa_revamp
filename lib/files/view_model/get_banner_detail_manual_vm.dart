import 'dart:math';
import 'package:mtn_sa_revamp/files/model/banner_detail_manual_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<BannerDetailManualModel> getBannerDetailManualApiCall(
    String bannerOrder, String bannerType) async {
  Random random = Random();
  int randomNumber = random.nextInt(1000000000);
  Map<String, dynamic> params = {
    'clientTxnId': randomNumber.toString(),
    'identifier': "GetBannerSongs",
    'bannerOrder': bannerOrder,
    'bannerType': StoreManager().isEnglish ? "3" : "6",
  };
  var parts = [];
  params.forEach((key, value) {
    parts.add('$key='
        '$value');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? res =
      await ServiceCall().post(bannerDetailManualUrl, formData);
  if (res != null) {
    BannerDetailManualModel mode = BannerDetailManualModel.fromJson(res);
    return mode;
  } else {
    return BannerDetailManualModel(statusCode: 'FL0000');
  }
}
