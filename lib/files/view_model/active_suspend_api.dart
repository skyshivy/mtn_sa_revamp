import 'package:mtn_sa_revamp/files/model/suspend_resume_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<SuspendResumeModel> activeSuspendApi(
    String packName, bool isSuspend, bool isCrbt) async {
  print("object url is $suspendResumePackUrl");
  var myPost = {
    "msisdn": StoreManager().msisdn,
    "feature": isSuspend ? "Suspend" : "Resume",
    "language": StoreManager().language,
    "priority": isCrbt ? "0" : "1",
    "packName": packName,
  };
  var parts = [];
  myPost.forEach((key, value) {
    parts.add('${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}');
  });
  var formData = parts.join('&');
  Map<String, dynamic>? res =
      await ServiceCall().post(suspendResumePackUrl, formData);

  print("result is $res");
  if (res != null) {
    return SuspendResumeModel.fromJson(res);
  } else {
    return SuspendResumeModel();
  }
}
