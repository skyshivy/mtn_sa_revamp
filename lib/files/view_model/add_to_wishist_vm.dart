import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/add_to_wishlist_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class AddToWishlistVm {
  Future<bool> add(TuneInfo? info) async {
    var myPost = {
      "identifier": "AddToWishList",
      "msisdn": StoreManager().msisdn,
      "contentId": info?.toneId,
      "contentName": info?.toneName,
      "path": info?.path ?? info?.toneIdStreamingUrl,
      "previewImage": info?.toneIdpreviewImageUrl,
      "album": info?.album ?? info?.albumName,
      "artist": info?.artist ?? info?.artistName,
      "price": "undefined",
      "language": StoreManager().language,
      "wishlistType": "1"
    };
    var parts = [];
    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value ?? '')}');
    });
    var formData = parts.join('&');
    Map<String, dynamic>? map =
        await ServiceCall().post(addToWishlistUrl, formData);
    if (map != null) {
      AddToWishListModel model = AddToWishListModel.fromJson(map);
      //isLoadWishlist
      if (model.statusCode == 'SC0000') {
        StoreManager().isLoadWishlist = true;
      }
      showSnackBar(message: model.message ?? '');
    } else {
      showSnackBar(message: someThingWentWrongStr.tr);
    }
    return true;
  }
}
