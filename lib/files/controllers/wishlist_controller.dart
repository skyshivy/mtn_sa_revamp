import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class WishlistController extends GetxController {
  RxBool isLoading = false.obs;

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
    print("\nformed data is \n$formData\n");
    Map<String, dynamic>? map =
        await ServiceCall().post(myWishListUrl, formData);
    isLoading.value = false;
    print(" ==== wishlist $map");
  }
}
