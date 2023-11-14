import 'dart:math';

import 'package:mtn_sa_revamp/files/model/delete_wishlist_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class DeleteFromWishlistVM {
  Future<DeleteWishlistModel> delete(String catId) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000000);
    var myPost = {
      "clientTxnId": '$randomNumber',
      "identifier": "DeleteFromWishList",
      "msisdn": StoreManager().msisdn,
      "wishlistType": "1",
      'catagoryId': catId,
      'language': StoreManager().language,
    };

    var parts = [];
    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');

    Map<String, dynamic>? map =
        await ServiceCall().post(deleteFromWishListUrl, formData);
    if (map != null) {
      DeleteWishlistModel model = DeleteWishlistModel.fromJson(map);
      return model;
    }
    return DeleteWishlistModel(message: someThingWentWrongStr, statusCode: '');
  }
}
