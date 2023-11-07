import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/model/wishlist_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

class WishlistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;
  getWishlist() async {
    isLoading.value = true;
    var myPost = {
      "msisdn": StoreManager().msisdn,
      "language": StoreManager().language,
      "identifier": "ViewWishListItems",
      "wishlistType": "1"
    };
    var parts = [];

    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });

    var formData = parts.join('&');
    printCustom("\nformed data is \n$formData\n");
    Map<String, dynamic>? map =
        await ServiceCall().post(myWishListUrl, formData);
    if (map != null) {
      WishlistModel model = WishlistModel.fromJson(map);
      list.value = model.responseMap?.toneDetailsList ?? [];
    }

    isLoading.value = false;
    printCustom(" ==== wishlist $map");
  }
}
