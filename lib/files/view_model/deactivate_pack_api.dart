import 'package:mtn_sa_revamp/files/model/pack_status_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<PackStatusModel> deactivatePackApi(String packName, bool isCrbt) async {
  Map<String, dynamic> params = {
    'msisdn': StoreManager().msisdn,
    'packName': packName,
    'priority': isCrbt ? "0" : "1",
    'language': StoreManager().language,
  };
  var parts = [];
  params.forEach((key, value) {
    parts.add('$key='
        '$value');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? map =
      await ServiceCall().post(deActivatePackUrl, formData);

  if (map != null) {
    PackStatusModel model = PackStatusModel.fromJson(map);
    return model;
  } else {
    return PackStatusModel(statusCode: "FL0000");
  }
}
