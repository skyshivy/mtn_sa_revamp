import 'package:mtn_sa_revamp/files/custom_files/date.dart';
import 'package:mtn_sa_revamp/files/model/history_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

Future<HistoryModel> getHistoryApi() async {
  var msisdn = StoreManager().msisdn;
  var backDate = GetDate().customDate(isBackMonth: true, month: 1);
  var currentDate = GetDate().customDate(isBackMonth: false, month: 0);
  var baseUrl = getHistoryUrl;
  //"https://funtone.ooredoo.com.mm/security/Middleware/api/adapter/v1/crbt/view-transactions-scm?";
  String url =
      "${baseUrl}msisdn=$msisdn&fromDate=$backDate&toDate=$currentDate";
  print("7url used currently is $url");

  Map<String, dynamic>? res = await ServiceCall().get(url);

  if (res != null) {
    HistoryModel historyModel = HistoryModel.fromJson(res);
    return historyModel;
  } else {
    return HistoryModel(statusCode: '');
  }
}
