import 'dart:io';
import 'dart:math';

import 'package:mtn_sa_revamp/files/model/edit_profile.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class ProfileVM {
  Future<Map<String, dynamic>?> getProfileDetail(String msisdn) async {
    var url = getprofileDetailUrl;
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);

    Map<String, dynamic> params = {
      'clientTxnId': '$randomNumber',
      'aPartyMsisdn': msisdn,
      'identifier': "GetUserDetails",
      'language': StoreManager().language,
    };
    var parts = [];
    params.forEach((key, value) {
      parts.add('$key='
          '$value');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? res = await ServiceCall().post(url, formData);
    return res;
  }

  Future<EditProfileModel?> editProfile(bool isCatUpdate,
      {String? catIs, String userName = ''}) async {
    var msisdn = StoreManager().msisdn;
    Random random = Random();
    var randomNumber = random.nextInt(1000000000);
    print(" randomNumber data is = 123");

    Map<String, dynamic> params = {
      'clientTxnId': '$randomNumber',
      'identifier': isCatUpdate ? 'UpdateCategories' : 'UpdateUserName',
      'aPartyMsisdn': msisdn,
      'servType': isCatUpdate ? 'UPDATE_CATAGORIES' : 'UPDATE_USER_NAME',
      'language': StoreManager().language,
      isCatUpdate ? "categoryId" : "name": isCatUpdate ? catIs : userName,
    };
    var parts = [];
    params.forEach((key, value) {
      parts.add('${key}='
          '${value}');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? res =
        await ServiceCall().post(editProfileUrl, formData);
    if (res != null) {
      EditProfileModel model = EditProfileModel.fromJson(res);
      return model;
    } else {
      return null;
    }
  }
}
