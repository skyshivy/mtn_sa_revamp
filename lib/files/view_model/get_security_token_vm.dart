import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class GetSecurityVM {
  Future<Map<String, dynamic>?> token() async {
    Map<String, dynamic>? map = await ServiceCall().get(getSecurityTokenUrl);
    return map;
  }
}
