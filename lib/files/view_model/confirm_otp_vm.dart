import 'package:mtn_sa_revamp/files/model/confirm_otp_existing_model.dart';
import 'package:mtn_sa_revamp/files/model/confirm_otp_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class ConfirmOtpVM {
  Future<ConfirmOtpModel> confirm(String msisdn, String otp) async {
    var params = {
      "otp": otp,
      "msisdn": msisdn,
      "language": StoreManager().language,
    };
    String url = confirmOtpUrl;
    var parts = [];
    params.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');

    Map<String, dynamic>? map =
        await ServiceCall().post(url, formData); //.post(url, formData);
    if (map != null) {
      ConfirmOtpModel model = ConfirmOtpModel.fromJson(map);
      return model;
    } else {
      ConfirmOtpModel model = ConfirmOtpModel(message: "Errror");
      return model;
    }
  }
}
